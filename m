Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0AE7F5691
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjKWCvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjKWCvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:51:05 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946FDA;
        Wed, 22 Nov 2023 18:51:11 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SbMzt3FHhzWhbc;
        Thu, 23 Nov 2023 10:50:34 +0800 (CST)
Received: from [10.174.185.179] (10.174.185.179) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 10:51:08 +0800
Subject: Re: [PATCH] KVM: selftests: aarch64: Remove unused functions from
 vpmu test
To:     Raghavendra Rao Ananta <rananta@google.com>
CC:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20231122221526.2750966-1-rananta@google.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bf4128c9-ce13-dba1-1ea3-825279e3dd76@huawei.com>
Date:   Thu, 23 Nov 2023 10:51:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20231122221526.2750966-1-rananta@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.179]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/23 6:15, Raghavendra Rao Ananta wrote:
> vpmu_counter_access's disable_counter() carries a bug that disables
> all the counters that are enabled, instead of just the requested one.
> Fortunately, it's not an issue as there are no callers of it. Hence,
> instead of fixing it, remove the definition entirely.
> 
> Remove enable_counter() as it's unused as well.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
