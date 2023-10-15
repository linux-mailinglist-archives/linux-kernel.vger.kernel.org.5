Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03A7C9905
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJOMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjJOMtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:49:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CFAAB
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 05:49:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31377C433C8;
        Sun, 15 Oct 2023 12:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697374184;
        bh=bGX5EnSl1r3ECoQfvfw2yVx4w/Y8jsMe3eiwHmVPzx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XtUOTO9n4ATh6p19eqhQ4kxhdL8h42A8tzk6YArSem6/Nuxz3Gn6b9nzl5P+UB12
         7XJijNZNS+ilqmjhijOkaRsJgOxpTj2F4uxDFyc1JYtOLnm1AQpT/VTYIi6XjEghLh
         AQvsyFns0nTj1KgUyOvpyc29JZa15pr+esWgJ3ow=
Date:   Sun, 15 Oct 2023 14:49:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] staging: rtl8192u: Mute checkpatch error
Message-ID: <2023101503-trial-move-4597@gregkh>
References: <cover.1697367161.git.gilbertadikankwu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697367161.git.gilbertadikankwu@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 12:06:46PM +0100, Gilbert Adikankwu wrote:
> Align descendant arguments to the open parenthesis as per the "Linux
> Kernel coding style" in Documentation/process/coding-style.rst
> 
> Mute the following checkpatch error:
> 
> CHECK: Alignment should match open parenthesis
> 
> Gilbert Adikankwu (6):
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments
>   staging: rtl8192u: Align descendant arguments

You have 6 patches here, with identical subject lines, yet obviously
they do different things.  Please fix that up to have unique subjects.

thanks,

greg k-h
