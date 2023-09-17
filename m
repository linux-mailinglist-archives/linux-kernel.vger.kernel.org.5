Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814787A372E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjIQSee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjIQSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:34:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97A94
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:33:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F16C433C7;
        Sun, 17 Sep 2023 18:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694975636;
        bh=cg+PdpBnP+iX58Kwp6lIkOY1AYHCnGOtuzyehGr02Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7lZS68M0ARWGaJ52tS95qC+tR7IQKi268X0kHXrn6shsT5ocnjZ0KbBN5cGSdJ0p
         uxCzEa7dudO4VlIqQV2j7o7p+2F3v0ake9iwBxH+SQ7N3Sef5DpDV3026pAvLBAVBj
         KjvjNrth05J1vF2k/L53U8C9eCkf7Xy+1Mq7QgCc=
Date:   Sun, 17 Sep 2023 20:33:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Piro Yang <piroyangg@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] staging: vme_user: Fixed prink formatting issues
Message-ID: <2023091744-suds-decree-377d@gregkh>
References: <20230917171824.76702-1-piroyangg@gmail.com>
 <20230917181149.77514-1-piroyangg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917181149.77514-1-piroyangg@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:11:49AM +0800, Piro Yang wrote:
> Fixed issues relating to prink message including:
> 
> a. using __func__ to replace function's name
> b. using pr_warn to replace "printk(KERN_ERR"
> 
> Issue found by checkpatch
> 
> Signed-off-by: Piro Yang <piroyangg@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Why is this a RESEND?
