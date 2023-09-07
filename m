Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD73797771
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbjIGQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbjIGQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C055FDB;
        Thu,  7 Sep 2023 09:22:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E63C32786;
        Thu,  7 Sep 2023 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694089465;
        bh=Pkcfr8cX6Y8Y4W+ikfkq4Yg6DoN+IDDSD7x6YH7QLvY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oTjQx0aAFot+wAOzKzYzqionLh7GbDYYitwmqmPY6NF/n4TrY9KdvZNQAw/VsjfpB
         RL/s7VsTxFK7Nk3PQgakOlW0D3TFTI5FlZk3KKaysVONLp+ynBIvxZ+tfs6i41zM/8
         FzCp7/Nkukq/ME6MNuzQ4FneDTWS9JuFxlmlEJYGui7GPqNxYZbu3UZh8gT07wrc7F
         5s+QpLlINpKH1Nd7+qsxsfZPRBFMkPsRk3dfZXTjWCyMzTXNlbbPoc+FNBiA1/ecZw
         bjrVKGzOSPvYm5te6aRU+SoAKw6BOe30tZS3sKgzfCcwv1q7NUm0A2p4Qad2m9ucQk
         pCb5Ub+gHj9cQ==
Message-ID: <f4d7981d-0cff-ddaf-26ad-f29f914813e2@kernel.org>
Date:   Thu, 7 Sep 2023 15:24:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 0/2] Add support for ICSSG on AM64x EVM
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113724.1228624-1-danishanwar@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230830113724.1228624-1-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/08/2023 14:37, MD Danish Anwar wrote:
> This series adds support for ICSSG driver on AM64x EVM.
> 
> First patch of the series adds compatible for AM64x EVM in icssg-prueth
> dt binding. Second patch adds support for AM64x compatible in the ICSSG 
> driver.
> 
> This series depends on [1] which is posted as RFC.
> 
> [1] https://lore.kernel.org/all/20230830110847.1219515-1-danishanwar@ti.com/
> 
> Thanks and Regards,
> Md Danish Anwar
> 
> MD Danish Anwar (2):
>   dt-bindings: net: Add compatible for AM64x in ICSSG
>   net: ti: icssg-prueth: Add AM64x icssg support

For this series:

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger
