Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF679CC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjILJ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjILJ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:57:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 709CAE64;
        Tue, 12 Sep 2023 02:57:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D9FC15;
        Tue, 12 Sep 2023 02:58:17 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E709A3F738;
        Tue, 12 Sep 2023 02:57:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:57:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the scmi tree
Message-ID: <20230912095737.zjhfkrhidevs5opi@bogus>
References: <20230912090947.7a099d53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912090947.7a099d53@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:09:47AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   2326b2f5bfe9 ("power: vexpress: Fix -Wvoid-pointer-to-enum-cast warning")
> 
> is missing a Signed-off-by from its committer.
> 

Sorry my bad. Initially I was expecting it to be sent via Sebastian's tree
but since I haven't got response yet I pushed it to -next hastily without
checking my signoff, now fixed and pushed. Thanks for the report.

-- 
Regards,
Sudeep
