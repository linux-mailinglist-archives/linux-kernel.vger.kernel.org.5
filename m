Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147007FAEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjK0X4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0X4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:56:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA75E4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:56:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D73C433C7;
        Mon, 27 Nov 2023 23:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701129366;
        bh=vzsJLkVjF5DQbuwiIC2KYyTCOYV47GwObWIW6Ubwtyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4vZOSFak2jLtlL+AfPmEAKEk+b+eQ4cGMifBo9VHf3HEiUHLEAfAXndQ7NWcEOH2
         rbww4owp9RZybgGBYBdAzc3oQlGnleOcEWBzo2+78TA1YY5Mv6Jfbhpf58EvicyXgf
         orAnRFV/Dk26rSGNAajLVj7nrTKscnlw4dhDFeiJj5X4uAZ8aKgmqThNm26c9DTxmJ
         aH3qaiZ1B276YSg2wF11T0v5UpWzPxvGnmVuisndUpwX137dgWjj7pT9xwKjpB+18N
         yPxyErj1lzZbZdzLB28aQSpjt6K97liCiPi05U6+v/B9atj0c7fZSH3dWCLZ2fA9iN
         5jdRFSBff797A==
Date:   Tue, 28 Nov 2023 00:56:02 +0100
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
Subject: Re: [PATCH v4 09/24] i2c: designware: Unify terminator in device ID
 tables
Message-ID: <20231127235602.kt6yzpn36srgkqnu@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-10-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-10-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:41:51PM +0200, Andy Shevchenko wrote:
> Make the terminator entry look the same in all device ID tables.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
