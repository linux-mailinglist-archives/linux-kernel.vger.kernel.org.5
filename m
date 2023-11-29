Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF42D7FE416
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjK2XMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjK2XMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:12:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF16A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:12:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37FFC433C8;
        Wed, 29 Nov 2023 23:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701299542;
        bh=HSts/RtmkEfp+hucOjG24Evpl8KCO+IZ46P7Gko2SYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeDIres4usu9TV865nZhvq8NuWquu28P645VlNhRqrBH0p79EnGADd5vGB5GKzHs+
         +6IlzcNlMEoCrmkCXC8AH2pVMpdlZg9+kDVMdSGL5rDDeh4SVCJBIUBtG5FmcjKS++
         CV0zFFnQRMvU5Fp3XOyhl1HgHJ821Ax/EtrszRAnOQ/qDlETD1DSC6SrfNAvRE5xQb
         LH6z2SXv9fjlK9BPKAPU7Oi56fMVsgXEqErjqMRLUqVswZ4eGcwIxy5+4QbCdKu5P6
         xNeZQ6Eiu3ERl6zj55/t1E2jGsmQjbBEIVoSLGLHcEh0vaVsJxVPbr+EFKasOoe+Uu
         7xJldqnvqwkGg==
Date:   Thu, 30 Nov 2023 00:12:18 +0100
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
Subject: Re: [PATCH v4 22/24] i2c: designware: Use temporary variable for
 struct device
Message-ID: <20231129231218.izcslvhss7frcam6@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-23-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-23-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:42:04PM +0200, Andy Shevchenko wrote:
> Use temporary variable for struct device to make code neater.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
