Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C90763D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGZRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGZRKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:10:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 124E51BD6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:10:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD0A82F4;
        Wed, 26 Jul 2023 10:11:21 -0700 (PDT)
Received: from [10.57.82.133] (unknown [10.57.82.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B63B73F67D;
        Wed, 26 Jul 2023 10:10:37 -0700 (PDT)
Message-ID: <f66c43ae-e1b0-c1e5-d695-9796fd7030e5@arm.com>
Date:   Wed, 26 Jul 2023 18:10:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] coresight: Fix all W=1 build warnings
To:     coresight@lists.linaro.org, James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230725140604.1350406-1-james.clark@arm.com>
 <169039093920.549048.3665369081970026970.b4-ty@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <169039093920.549048.3665369081970026970.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 18:06, Suzuki K Poulose wrote:
> On Tue, 25 Jul 2023 15:06:04 +0100, James Clark wrote:
>> The kernel test robot looks for new warnings in a W=1 build, so fix all
>> the existing warnings to make it easier to spot new ones when building
>> locally.
>>
>> The fixes are for undocumented function arguments and an incorrect doc
>> style.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] coresight: Fix all W=1 build warnings
>        https://git.kernel.org/coresight/c/04e8429c5b4f644257fe64db3403205a7a41e33b

Apologies, that should be:

  https://git.kernel.org/coresight/c/04e8429c5b4f

Suzuki


