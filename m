Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962137A7A21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbjITLLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjITLLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:11:00 -0400
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F48B4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:10:54 -0700 (PDT)
Message-ID: <0ae9f426-7225-ac4b-4ecd-d53e36dbf365@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695208252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahWAoqjkjHE7OKtu8gYBWsnzFn2eGN8zPA0rlWEMIgU=;
        b=uHAbTRnk6FKa0i1DNUr+weL5Zd/1izaFg50KVEVqeHBZCFN4CoB7Yc3A/jKs2MPjg8pAyb
        6STsBpkkmeCh8xmixYuuXBdRADSdxM8cat+FTOdB1Yp5HRBwb55kkNlfw/tolSQs/1xo2S
        KPJx/SpvUE0UOk3Eq/78q9Lp+HAmetw=
Date:   Wed, 20 Sep 2023 12:10:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>,
        arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 02:03, Yang Li wrote:
> ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6605
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Hi Yang!
There was a report from Intel's bot too about the issue, could you 
please add the tags from it?

Reported-by: kernel test robot <lkp@intel.com>
Closes: 
https://lore.kernel.org/oe-kbuild-all/202309190540.RFwfIgO7-lkp@intel.com/

Thanks!

> ---
>   drivers/dpll/dpll_netlink.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 764437a0661b..e20daba6896a 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -844,7 +844,7 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
>   				return ERR_PTR(-EINVAL);
>   			}
>   			pin_match = pin;
> -		};
> +		}
>   	}
>   	if (!pin_match) {
>   		NL_SET_ERR_MSG(extack, "not found");

