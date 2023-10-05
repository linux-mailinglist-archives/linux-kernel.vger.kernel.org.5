Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01907BA719
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjJEQuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjJEQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:48:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EBDD1BB
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:41:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86CB2C15;
        Thu,  5 Oct 2023 09:42:15 -0700 (PDT)
Received: from [10.57.2.226] (unknown [10.57.2.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F10073F5A1;
        Thu,  5 Oct 2023 09:41:33 -0700 (PDT)
Message-ID: <f33a9903-4c6e-53b4-8a24-f5afe2e1cced@arm.com>
Date:   Thu, 5 Oct 2023 17:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/6] arm64: KVM: Rename DEBUG_STATE_SAVE_TRBE to
 DEBUG_STATE_SAVE_TRFCR
To:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        broonie@kernel.org, maz@kernel.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
References: <20231005125757.649345-1-james.clark@arm.com>
 <20231005125757.649345-3-james.clark@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20231005125757.649345-3-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 13:57, James Clark wrote:
> This flag actually causes the TRFCR register to be saved, so rename it
> to that effect.
> 
> Currently it only happens when TRBE is used, but in a later commit
> TRFCR will be saved and restored even if TRBE isn't used, so the new
> name will be more accurate.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


