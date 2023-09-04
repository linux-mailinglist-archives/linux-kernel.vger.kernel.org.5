Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F0C7912E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349122AbjIDIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIDIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:05:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A093F4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:05:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C491A11FB;
        Mon,  4 Sep 2023 01:06:32 -0700 (PDT)
Received: from [10.57.91.85] (unknown [10.57.91.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9AE3F8A4;
        Mon,  4 Sep 2023 01:05:53 -0700 (PDT)
Message-ID: <977b845a-eb99-ec53-3aa9-a395744b68a2@arm.com>
Date:   Mon, 4 Sep 2023 09:05:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] MAINTAINERS: Remove myself as a Arm CoreSight reviewer
To:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230518095345.1755105-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230518095345.1755105-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo

On 18/05/2023 10:53, Leo Yan wrote:
> I haven't done any meaningful work for a long while on Arm CoreSight and
> it's unlikely I'll be able to do related work in the future.
> 
> Remove myself from the Arm CoreSight "Reviewers" list.

Apologies for missing this one. Trust me, it was not intentional ;-)
This however conflicts with what we have in next. Are you able to
resend this at -rc1 ?

Suzuki

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..342b8a3e19e3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2102,7 +2102,6 @@ N:	digicolor
>   ARM/CORESIGHT FRAMEWORK AND DRIVERS
>   M:	Suzuki K Poulose <suzuki.poulose@arm.com>
>   R:	Mike Leach <mike.leach@linaro.org>
> -R:	Leo Yan <leo.yan@linaro.org>
>   L:	coresight@lists.linaro.org (moderated for non-subscribers)
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained

