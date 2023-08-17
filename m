Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1C77F3FF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349848AbjHQKCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjHQKBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:01:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B74512D61
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 03:01:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6877CD75;
        Thu, 17 Aug 2023 03:02:26 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E97A83F64C;
        Thu, 17 Aug 2023 03:01:43 -0700 (PDT)
Message-ID: <7cd0970f-c8a4-dd99-c27f-542fef608249@arm.com>
Date:   Thu, 17 Aug 2023 11:01:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] coresight: trbe: Allocate platform data per device
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>, hejunhao3@huawei.com
Cc:     coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
        leo.yan@linaro.org, mike.leach@linaro.org, james.clark@arm.com,
        linuxarm@huawei.com, yangyicong@huawei.com,
        prime.zeng@hisilicon.com
References: <20230814093813.19152-1-hejunhao3@huawei.com>
 <20230816141008.535450-1-suzuki.poulose@arm.com>
 <20230816141008.535450-2-suzuki.poulose@arm.com>
 <9cd9f83c-7778-2d87-a175-a4cb7ceb8723@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9cd9f83c-7778-2d87-a175-a4cb7ceb8723@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2023 07:37, Anshuman Khandual wrote:
> Hi Suzuki,
> 
> Seems like this patch is going to conflict with the below proposed change
> 
> https://lore.kernel.org/all/20230817055405.249630-4-anshuman.khandual@arm.com/
> 
> Please let me know how should we resolve this conflict.

Please rebase your change on top of this one.

Suzuki


