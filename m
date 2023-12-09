Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBC80B152
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjLIBOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIBOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:14:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C5FE9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:14:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB189C433C7;
        Sat,  9 Dec 2023 01:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702084485;
        bh=yW/oNjayrBgmBQcnKaR/BHHHylnywMfGm38sEfYKmLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m10ex5B7xuxpfbrUpv9WoB9vpJEyd34DLVdb1+6i+oxZrtIHQZEp4rJj/ADeVjkWA
         Evx5Z0HXbeHMAPOes8z3rRfUE2EM6zPoDc3HP408d7+g48J21i4Qrfsbn/D/5Akmf9
         9QuLA2W/B9hO7s6TX49TMZ3D3Zgy0CFUa6dy84cOg7nPNME/XX1VQz+K1ZyOJP5ul/
         t4nm//F4NHhuTQNbjRpOkHDvjG9QsLtf4ddo090XwyGvD2Gk5Nz6jqyUOzqO5bLp4J
         Q7OqPWZntFPWHM1XARaCXH1cnMpe5e7EWYwiODBvTKAfCteHZagvzy/3wIWxKzU9X4
         wvXhsKo87Ky/g==
Date:   Sat, 9 Dec 2023 02:14:36 +0100
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
Subject: Re: [PATCH v5 24/24] i2c: designware: Fix spelling and other issues
 in the comments
Message-ID: <20231209011436.rwvaivgewhbthtzl@zenone.zhora.eu>
References: <20231207141653.2785124-1-andriy.shevchenko@linux.intel.com>
 <20231207141653.2785124-25-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207141653.2785124-25-andriy.shevchenko@linux.intel.com>
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

On Thu, Dec 07, 2023 at 04:14:04PM +0200, Andy Shevchenko wrote:
> Fix spelling and other issues, such as kernel-doc reported about,
> in the comments. While at it, fix some indentation issues as well.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Link: https://lore.kernel.org/r/20231120144641.1660574-25-andriy.shevchenko@linux.intel.com
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi I think everything here has been reviewed.

Thanks,
Andi
