Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034EE7FA196
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjK0NzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjK0Ny2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D89D1BDA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D53DC41679;
        Mon, 27 Nov 2023 13:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093268;
        bh=LgvZU5k7cgHeOMUcETAIPa4Pu0VIlDFzMv+d5VcByyY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MphXs9btSX61mRsNhuH7amT+CEyvbZGPGONeRjDm1bDwnQxl9FbO/xMVPVw8ZXQG2
         1+z2XV6Yf4mLvll0mvsHjNj1u6jHpBsRe1MqloE/lELxahquKtzbACVTwMQu6UvOdu
         nYl0ff4tkT1bcGyIwRTf3+R9xxTuh41nZMXUve34=
Date:   Mon, 27 Nov 2023 13:40:07 +0000
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] misc: rtsx: add to support new card reader
 rts5264 new  definition and function
Message-ID: <2023112714-tarmac-reapprove-7f75@gregkh>
References: <bf45a73f01cc43669dc3796ccff25598@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf45a73f01cc43669dc3796ccff25598@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 03:55:30AM +0000, Ricky WU wrote:
> rts5264.h new definitions for new chip rts5264
> rts5264.c new functions for new chip rts5264

I'm sorry, but I do not understand this changelog at all.

As my bot would say:

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

Please read that and fix up and resend this as a proper patch series
(your patches are not connected somehow).

thanks,

greg k-h
