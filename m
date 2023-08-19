Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1F78180F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344302AbjHSHgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344275AbjHSHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:36:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 390823ABA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:36:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 598032F4;
        Sat, 19 Aug 2023 00:37:12 -0700 (PDT)
Received: from [10.57.3.66] (unknown [10.57.3.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4E03F64C;
        Sat, 19 Aug 2023 00:36:29 -0700 (PDT)
Message-ID: <f8f13510-ec6a-b18b-d9ff-9247b250bc03@arm.com>
Date:   Sat, 19 Aug 2023 08:36:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
To:     Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

On 18/08/2023 19:04, Will Deacon wrote:
> On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
>> This series enables detection of ACPI based TRBE devices via a stand alone
>> purpose built representative platform device. But as a pre-requisite this
>> changes coresight_platform_data structure assignment for the TRBE device.
>>
>> This series is based on v6.5-rc5 kernel, is also dependent on the following
>> EDK2 changes posted earlier by Sami.
>>
>> [...]
> 
> Applied to will (for-next/perf), thanks!
> 
> [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
>        https://git.kernel.org/will/c/81e5ee471609
> [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
>        https://git.kernel.org/will/c/1aa3d0274a4a
> [3/4] coresight: trbe: Add a representative coresight_platform_data for TRBE
>        https://git.kernel.org/will/c/e926b8e9eb40

This will conflict with what I have (already) sent to Greg for
coresight/next. Please let me know how you would like handle it

Suzuki

> [4/4] coresight: trbe: Enable ACPI based TRBE devices
>        https://git.kernel.org/will/c/0fb93c5ede13
> 
> Cheers,

