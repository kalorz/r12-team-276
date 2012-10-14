require 'spec_helper'

describe Repo do
  use_vcr_cassette :repos

  context ' fetch_repo_attrs ' do
    it ' returns valid attributes ' do      
      Repo.fetch_repo_attrs("samuil/sxrb").tap do |attr|
        attr["fullname"].should be
      end
    end

    it ' returns defaults for dead-repo ' do
      Repo.fetch_repo_attrs("samuil/sxrbxxxxxx").tap do |attr|
        attr["fullname"].should be
      end
    end
    
  end
end
