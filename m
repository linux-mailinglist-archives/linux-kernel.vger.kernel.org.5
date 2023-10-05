Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30297BA6AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjJEQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjJEQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83142117
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:51:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78392C4AF7B;
        Thu,  5 Oct 2023 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696513870;
        bh=QQU3XE1RqrzgsIa0O6msst/9V6vgqAWJla450bW0CkE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=CxgDmuf+hTPIlfrGI5fmB8DxeXFYBh9+GBbm3QwCzpEL7tibSyaVhE1UDkpx0tTUH
         n42KYI708YmGk7CEHJ7Pn4z9dZoWsd0LAjayiDWBMGClS8QJ8wUE1jVn93xnb1I+ay
         HHhxhUZeor3Hcz2wm0I+VgoxrehHfNEcLr4gqEhYNOF2lC26O1ShCVUUPp/nS8KvJK
         M4aUrPMQLZmN6oF7GX8zTyQp9ODo5jtYrbcBSABvs7ooSfLwpPk0oQH0dHRdJumRet
         IQDwCsshDJ32e+ST4rxTDH+vUy0Dfc1m4jc1liR0LcY+JEOWajf/GoSwwnbl5y/XNH
         oCJuE7mX1/yoA==
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231002083344.75611-1-jarkko.nikula@linux.intel.com>
References: <20231002083344.75611-1-jarkko.nikula@linux.intel.com>
Subject: Re: (subset) [PATCH] mfd: intel-lpss: Add Intel Lunar Lake-M PCI
 IDs
Message-Id: <169651386914.775665.8508120735864164763.b4-ty@kernel.org>
Date:   Thu, 05 Oct 2023 14:51:09 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2023 11:33:44 +0300, Jarkko Nikula wrote:
> Add Intel Lunar Lake-M SoC PCI IDs.
> 
> 

Applied, thanks!

[1/1] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
      commit: ae1fbe1b021a3075020856b2717fd971a72f9429

--
Lee Jones [李琼斯]

