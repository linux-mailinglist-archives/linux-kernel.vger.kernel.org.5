Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF807D22DE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjJVLUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjJVLUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:20:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30864E8;
        Sun, 22 Oct 2023 04:20:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725A7C433C8;
        Sun, 22 Oct 2023 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697973600;
        bh=Mg6hajx48C9/LEuN7kgioSJmku4tU+Nwv0q9EXNVnhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DJokRb4zg1kGdS4g4ZwE2OoW/4JO3yuM+DlXJJ7fDJro0DW8x4dmNr2SxtHHUbavX
         vOVEEIwOp/lwnw1nt5jqyfQCRqvCXdcMSQXv+A6BJH5i1OyOl28Erxv4w8MF8SdXyi
         jexDbOd8oBij9LHwxLm2EmyAaOTmustSb2dAPZpQ=
Date:   Sun, 22 Oct 2023 13:19:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 1/3] tty: whitespaces in descriptions corrected by
 replacing tabs with spaces
Message-ID: <2023102251-playoff-utensil-0457@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-2-fe@dev.tdt.de>
 <2023102110-starlight-wispy-1f28@gregkh>
 <dce966de5bec159dae67d958653aaa42@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce966de5bec159dae67d958653aaa42@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 12:24:55PM +0200, Florian Eckert wrote:
> On 2023-10-21 18:28, Greg KH wrote:
> > On Thu, Oct 19, 2023 at 01:28:07PM +0200, Florian Eckert wrote:
> > > Tabs were used in the function description, to make this look more
> > > uniform, the tabs were replaced by spaces where necessary.
> > > 
> > > While we're at it, I also replaced the 'ndashes' with simple dashes,
> > > since
> > > only those are supported by sphinx.
> > > 
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > ---
> > >  drivers/tty/tty_io.c | 102
> > > +++++++++++++++++++++----------------------
> > >  1 file changed, 51 insertions(+), 51 deletions(-)
> > 
> > This didn't apply cleanly as portions of this patch were already in my
> > tree, what did tree did you make it against?
> 
> I have already seen that I should add a base commit next time.
> So I made it against the master from last week.
> 
> However, I was not sure which tree to use as I am changing
> something in the tty and led subsystem-
> 
> > Anyway, I've fixed it up and taken it now.
> 
> Thank you for adopting my change and correcting my commit so that
> it can be applied cleanly.
> 
> I will not add this patch in the next series, as it is already in the
> tty-testing branch [1] from you?

That is correct, thanks!

greg k-h
