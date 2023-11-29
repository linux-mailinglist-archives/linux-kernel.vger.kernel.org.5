Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0530A7FE402
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbjK2XJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:09:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB36DA2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:10:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C90C433C8;
        Wed, 29 Nov 2023 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701299403;
        bh=ibTbb2JNsJh/AaZjyoNVotpyQoFG4eK1lbgyEx8xpCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Opc58t9fPZa0AVPpOo2nIi2K1egrAEIDBg6qug2GR6/sqi6UfaEsl6AQCpWGbU2gm
         qZZhz4KY6drNF1ELRc7/9GfcL2I3XB/RpT/XmkgR2Qzydq5/JOKO3XVq0NWG7yt6Ik
         IzvwXb7gGqi7fVCd0kK4OOf/ZjKmnvOxMEDGs8U4jG+JGSt5f8di5rxm7yQFVM4uZG
         5jJvBmgXdRTzx0Cebz0vPxRRvGEc0dO9RJBTmPEKr8g3nF0mRHa03IOo6+v08rOF22
         0Zo2glg91w57Ui3wBj47icjMERzGvvkDEbclgzCGaaMnVby+n7whC/yO34pY57l0pR
         cDooBtUQN3VVQ==
Date:   Thu, 30 Nov 2023 00:09:59 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 20/24] i2c: designware: Propagate firmware node
Message-ID: <20231129230959.uuqcp5c5ao4ge7ud@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-21-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-21-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:42:02PM +0200, Andy Shevchenko wrote:
> Propagate firmware node by using a specific API call, i.e. device_set_node().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
