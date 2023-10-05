Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCF7BA057
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbjJEOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjJEOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E109526C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:52:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE5CC43140;
        Thu,  5 Oct 2023 07:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696492538;
        bh=7xOGM03y69uffWbZv9bkXu3YfXv+0u6k/RTRiM3+i6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPgHqoFyx5SNfutFWp96HsUtfj/gqhRJQwubvYxCDpMuMUMQHtEetE7iksY84tgOC
         GRZ4mOhG44IZpRcTmAsL3MYkCQuFx+opZ42F9Wel4h2/lg528cTx1vsIMSIjV9vnxz
         rXiXtFFTQ91qDLNJIC2AaTOw2YkM6XFw0cFgOZcc=
Date:   Thu, 5 Oct 2023 09:55:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8192e: renamed (3) variables
Message-ID: <2023100529-mounting-sandpaper-5fe2@gregkh>
References: <20230928000225.27912-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928000225.27912-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 08:02:25PM -0400, Gary Rookard wrote:
> This patch renames the vaiable in staging/rtl8192e

You did not rename a variable.

> HTUpdateDefaultSetting -> ht_update_default_setting

That is only one rename, not 3.

> in (3) files of rtl8192e:
> 1) rtl819x_HTProc.c
> 2) rtllib.h
> 3) rtllib_module.c
> 
> Linux Kernel Coding Style "cleanup", no change in runtime,
> staging/rtl8192e builds before and after.

I can not parse these lines :(

Please read the documentation for how to write a good changelog subject
and text, that's one of the most important parts of getting a kernel
change accepted.

thanks,

greg k-h
