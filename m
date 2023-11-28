Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDD17FC2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbjK1RsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjK1RsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:48:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D9B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:48:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97258C433C9;
        Tue, 28 Nov 2023 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701193703;
        bh=xYeLkREJkq6n1zWQOI2iv9pswdUrixGfu5ZhAwu/Nzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtJRQ0OeuW1aWyMxPMS7HJTbmrsI+mEH3wx5V5KtqFCZL0pd0VIKIfjHPhDGQTX/r
         COL7GZqmIqZZragTbRjvqnkeB0DB5x8+ybII/lvmB4hLT2HUU0BqB0TrVPkGM75U/x
         8tLEGSqKxrKMHpyritqd/v4sWeug5wSo8yJxk02mSQG57G5cMG19mEE2FMBZI1O+yL
         BjOQ8/PDv1bP5jrYQq7ui3kb9U5b30kudFbozA6E9dTjdCocDzhgNJZhjRB+7LNit2
         Ai7SR9/79+Ai4irisjul2wXTFPSCHrO6fw7AUYfcLBr6QsN/wjDbvw8tR7owLiiwDb
         +1ZkCXrUGHXPg==
Date:   Tue, 28 Nov 2023 18:48:18 +0100
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
Subject: Re: [PATCH v4 16/24] i2c: designware: Move exports to I2C_DW
 namespaces
Message-ID: <20231128174818.phbil2xatmkbugxr@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-17-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120144641.1660574-17-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:41:58PM +0200, Andy Shevchenko wrote:
> Reduce scope of the I²C DesignWare driver exports to I2C_DW namespaces.
> This will prevent abuse of the symbols and clean up global namespace.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
