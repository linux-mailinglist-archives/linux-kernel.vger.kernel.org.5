Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F378C1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjH2Jzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjH2Jz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:55:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0149EEA;
        Tue, 29 Aug 2023 02:55:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04B592F4;
        Tue, 29 Aug 2023 02:56:02 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C28D3F738;
        Tue, 29 Aug 2023 02:55:20 -0700 (PDT)
Date:   Tue, 29 Aug 2023 10:55:18 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>, rafael@kernel.org,
        rafael.j.wysocki@intel.com
Cc:     robbiek@xsightlabs.com, guohanjun@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghuiqiang@huawei.com, zhangzekun11@huawei.com,
        wangxiongfeng2@huawei.com, tanxiaofei@huawei.com,
        wangkefeng.wang@huawei.com, liuyonglong@huawei.com
Subject: Re: [PATCH RESEND v4 0/2] mailbox: pcc: Support platform
 notification for type4 and shared interrupt
Message-ID: <20230829095518.5sr256j4yapmclnz@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230801063827.25336-1-lihuisong@huawei.com>
 <20230801093831.dkamhtuvamjalhaa@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801093831.dkamhtuvamjalhaa@bogus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Tue, Aug 01, 2023 at 10:38:31AM +0100, Sudeep Holla wrote:
> Hi Rafael,
> 
> On Tue, Aug 01, 2023 at 02:38:25PM +0800, Huisong Li wrote:
> > PCC supports processing platform notification for slave subspaces and
> > shared interrupt for multiple subspaces.
> >
> 
> These changes have missed last 2 merge window. Let us know if you can pull
> this for v6.6 or you prefer to route this via mailbox.
> 

Sorry for the nag. Do you prefer pull request for this ? Since it was just 2
patch I didn't add that option before. Let me know.

-- 
Regards,
Sudeep
