Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFD7A0A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbjINQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjINQOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:14:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3F01BE1;
        Thu, 14 Sep 2023 09:14:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4249D1FB;
        Thu, 14 Sep 2023 09:15:12 -0700 (PDT)
Received: from bogus (unknown [10.57.93.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD3F3F738;
        Thu, 14 Sep 2023 09:14:33 -0700 (PDT)
Date:   Thu, 14 Sep 2023 17:13:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     rafael@kernel.org, rafael.j.wysocki@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuyonglong@huawei.com
Subject: Re: [PATCH] mailbox: pcc: export the PCC subspace type
Message-ID: <20230914161335.rz6fn4w2pqzz4wdp@bogus>
References: <20230914115753.9064-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914115753.9064-1-lihuisong@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 07:57:53PM +0800, Huisong Li wrote:
> As stated in APCI spec, the size of the subspace shared memory region may
> be different for different types. So it is useful for driver to fill PCC
> communication space. But the driver used this PCC channel doesn't know what
> is the subspace type of the channel.
> 
> So export the PCC subspace type by requesting PCC channel.
>

I would prefer to avoid this, but please post it with user to get better
understanding of it.

-- 
Regards,
Sudeep
