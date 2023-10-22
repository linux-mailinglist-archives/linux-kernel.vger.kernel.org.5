Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262D7D22D5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJVLSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:18:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2136BE5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:18:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082FC433C8;
        Sun, 22 Oct 2023 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697973521;
        bh=7HLrsmOIb/DsMFPqh3P97aAYxVWou/9n9huI2vTErUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=afBYMa61PkdIdJQViO3od6LRZ597VUgJM5vacKWgQ8WKaLcu/TMmQRIecWLsg7uo3
         yjMkTKg+c3aIPME85+ZxaMfsDQD/difEl/lB/H1Y4tj7gAYwmo/nDkaWx+cBMwzwyY
         XYUBp21Y1Y7AxPg65QRciAxCDYrgZCWM82npfLUE=
Date:   Sun, 22 Oct 2023 13:18:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumaran.4353@gmail.com
Subject: Re: [PATCH 1/3] staging: greybus: Modify lines end with a '('
Message-ID: <2023102217-irregular-accurate-a84a@gregkh>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
 <827f8417afa3943e8b71910a7ba88ea35614dd2c.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <827f8417afa3943e8b71910a7ba88ea35614dd2c.1697969950.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 03:39:28AM -0700, Nandha Kumar Singaram wrote:
> Adhere to linux coding style. Reported by checkpatch.pl:
> CHECK: Lines should not end with a '('
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Subject line should be:
	"staging: greybus: camera: Modify..."
right?

thanks,

greg k-h
