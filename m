Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9FC76AEB7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjHAJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjHAJkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:40:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBD1F3C34;
        Tue,  1 Aug 2023 02:38:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FB17D75;
        Tue,  1 Aug 2023 02:39:19 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A38E3F5A1;
        Tue,  1 Aug 2023 02:38:34 -0700 (PDT)
Date:   Tue, 1 Aug 2023 10:38:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>, rafael@kernel.org,
        rafael.j.wysocki@intel.com
Cc:     robbiek@xsightlabs.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghuiqiang@huawei.com, zhangzekun11@huawei.com,
        wangxiongfeng2@huawei.com, tanxiaofei@huawei.com,
        wangkefeng.wang@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform
 notification for type4 and shared interrupt
Message-ID: <20230801093831.dkamhtuvamjalhaa@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230801063827.25336-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801063827.25336-1-lihuisong@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Aug 01, 2023 at 02:38:25PM +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.
>

These changes have missed last 2 merge window. Let us know if you can pull
this for v6.6 or you prefer to route this via mailbox.

-- 
Regards,
Sudeep
