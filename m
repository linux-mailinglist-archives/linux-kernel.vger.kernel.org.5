Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A9782D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbjHUPZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236263AbjHUPZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:25:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA13FE2;
        Mon, 21 Aug 2023 08:25:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E07B2F4;
        Mon, 21 Aug 2023 08:25:55 -0700 (PDT)
Received: from [10.57.91.118] (unknown [10.57.91.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0A43F740;
        Mon, 21 Aug 2023 08:25:12 -0700 (PDT)
Message-ID: <7dfefc7f-cc86-01a1-2b8a-58e025ecfaf9@arm.com>
Date:   Mon, 21 Aug 2023 16:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/12] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
References: <20230721155022.2339982-1-lukasz.luba@arm.com>
 <20230721155022.2339982-9-lukasz.luba@arm.com>
 <8fa02b18-7e41-eaea-f054-6842f6e310c6@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <8fa02b18-7e41-eaea-f054-6842f6e310c6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/23 14:05, Dietmar Eggemann wrote:
> On 21/07/2023 17:50, Lukasz Luba wrote:
>> This patch introduces the new feature: modifiable EM perf_state table.
> 
> nit pick: The first sentence doesn't add any information. I would skip it.
> 
> [...]
> 
>> The runtime modifiable EM data is used by the Energy Aware Scheduler (EAS)
>> for the task placement. The EAS is the only user of the 'runtime
>> modifiable EM'.
> 
> The runtime modifiable EM is currently only used ...
> The you can skip the next sentence: "The EAS is the only user ..."
> 
> All the other users (thermal, etc.) are still using the
>> default (basic) EM. This fact drove the design of this feature.
> 
> [...]
> 

Thanks, I'll remove them in the next version.
