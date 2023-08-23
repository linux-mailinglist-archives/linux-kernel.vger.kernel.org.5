Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C123786255
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbjHWV2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjHWV1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:27:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A49FCEE;
        Wed, 23 Aug 2023 14:27:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDC0666304;
        Wed, 23 Aug 2023 21:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44221C433C7;
        Wed, 23 Aug 2023 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692826066;
        bh=PadaEDKvbss1R09ksA7Vme1mVb0BrzW+7fddYJQYEaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7jfPp6Aj1qdjwNSgeYeMpl+cecQAz9UnceJeNiS3tXrK7yDAnqnYhhibDcKy3pEp
         oDLdou4O364SGzCx+99PH0uCw/VzOf6YWNvvkKhR6agof3eQZimKW3RC0tjjLSVpvP
         8ewDzRjTlM8nRykfj/930byab09ZdWYyefZxCkjqx3ND6TM8FTgsh9O3GzG/p04j6j
         ct9OtGmywDazNfzio0WSd8QIq5WZryPWlkvFAUmiPCKh60Ch18X89hmWS+Bd+BPwvX
         aFu+Mzw5p1A2pQhQU0fIk/il860LN2kampPKOtgmGvcGlS/kn+yHg8YdvR9k9suffP
         42OX8Fpcs0OSg==
Received: (nullmailer pid 2915007 invoked by uid 1000);
        Wed, 23 Aug 2023 21:27:44 -0000
Date:   Wed, 23 Aug 2023 16:27:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Fabio Estevam <festevam@denx.de>, giometti@enneenne.com,
        linux-doc@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] MAINTAINERS: pps: Update pps-gpio bindings location
Message-ID: <169282605431.2914753.6885024870777628111.robh@kernel.org>
References: <20230822213317.60798-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822213317.60798-1-festevam@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 18:33:17 -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> The pps-gpio bindings have been converted to yaml.
> 
> Update the file path accordingly.
> 
> Fixes: 7ceb60ece856 ("dt-bindings: pps: pps-gpio: Convert to yaml")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308230517.n0rrszYH-lkp@intel.com/
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

