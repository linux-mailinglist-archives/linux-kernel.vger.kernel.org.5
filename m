Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6D7BCD3E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbjJHIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjJHIpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:45:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3993C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:45:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B204C15;
        Sun,  8 Oct 2023 01:46:23 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D66B23F762;
        Sun,  8 Oct 2023 01:45:41 -0700 (PDT)
Date:   Sun, 8 Oct 2023 09:44:10 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] firmware: arm_scmi: Remove unneeded semicolon
Message-ID: <20231008084410.5et654qown5mqn2p@bogus>
References: <20231007012058.4084-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007012058.4084-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:20:58AM +0800, Yang Li wrote:
> ./drivers/firmware/arm_scmi/clock.c:236:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6717
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/firmware/arm_scmi/clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> index ddaef34cd88b..432812205775 100644
> --- a/drivers/firmware/arm_scmi/clock.c
> +++ b/drivers/firmware/arm_scmi/clock.c
> @@ -233,7 +233,7 @@ static int iter_clk_possible_parents_update_state(struct scmi_iterator_state *st
>  		}
>  
>  		st->max_resources = st->num_returned + st->num_remaining;
> -	};
> +	}
>  

The patch introducing this is being waited for an Ack and not finalised yet.
I will fold in the changes. Thanks for pointing it out, much appreciated!

-- 
Regards,
Sudeep
