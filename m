Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98A80B14C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjLIBMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:12:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13D1DA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:12:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A9C433C7;
        Sat,  9 Dec 2023 01:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702084375;
        bh=McEaU9YApVXXwgVd14zRJ/m9N5xIfeTdb+EvPe13yEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK50ULOJN9nIj+wbn0+MpbHCuYEyBK5WLxjvE1XD02LNNQELZJvYZh1nA0sbPJizN
         94nEP3qbSti5bC3oCd5hq1LVqpSSHIginUjpEalnGuP+efJ/1nK5b+DquqoRB4PvcN
         olo2q62qajM0dBAxJgYD4yrmAscuex+YXxRto8a2sC7WcBIcVRssKJjxKCA2rFh3eZ
         XLqg7DTBDbjmhv/5G9mpacl/0jaDujQhcjh/UkMi6b/mZ55T2KkIO+Bf71korZ9j6x
         E/1/Rsbvflhe6eW5TW4MStwG8nvtft9fZ/zNK19qheFUvE22JATt5ZNuDBVCyK036n
         ywD3zDvtN1HCA==
Date:   Sat, 9 Dec 2023 02:12:46 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v5 07/24] i2c: designware: Add missing 'c' into PCI IDs
 variable name
Message-ID: <20231209011246.c7on5pc4x2373qez@zenone.zhora.eu>
References: <20231207141653.2785124-1-andriy.shevchenko@linux.intel.com>
 <20231207141653.2785124-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207141653.2785124-8-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Dec 07, 2023 at 04:13:47PM +0200, Andy Shevchenko wrote:
> Add missing 'c' into i2c_designware_pci_ids variable name.
> 
> While at it, move the id_table member after the driver to
> be consistent with platform glue driver code.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Link: https://lore.kernel.org/r/20231120144641.1660574-8-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
