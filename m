Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518C7AA170
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjIUVCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjIUVBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:01:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9165BAF96F;
        Thu, 21 Sep 2023 11:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20914169C;
        Thu, 21 Sep 2023 06:52:55 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FCB33F59C;
        Thu, 21 Sep 2023 06:52:16 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     rafael@kernel.org, rafael.j.wysocki@intel.com,
        robbiek@xsightlabs.com, guohanjun@huawei.com,
        Huisong Li <lihuisong@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, wangkefeng.wang@huawei.com,
        liuyonglong@huawei.com
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform notification for type4 and shared interrupt
Date:   Thu, 21 Sep 2023 14:52:13 +0100
Message-ID: <169530429882.3222950.12070743250083833774.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230801063827.25336-1-lihuisong@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com> <20230801063827.25336-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 14:38:25 +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
> 

Applied to sudeep.holla/linux (for-next/pcc/updates), thanks!

[1/2] mailbox: pcc: Add support for platform notification handling
      https://git.kernel.org/sudeep.holla/c/60c40b06fa68
[2/2] mailbox: pcc: Support shared interrupt for multiple subspaces
      https://git.kernel.org/sudeep.holla/c/3db174e478cb
--
Regards,
Sudeep

