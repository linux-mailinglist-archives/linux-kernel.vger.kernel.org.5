Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5327C7797BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbjHKT1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjHKT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEA030F2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07F9F65832
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 19:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCDAC433C7;
        Fri, 11 Aug 2023 19:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691782038;
        bh=W/VF8Zp6tTVBYPmM0z22LQHZ1/MyHeLrHhuuk5KfTy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=191gE3jlMDf28ibYBu9W/mD1SG9WCkhGBtS6hT3dNYTMSHOpCxcVDgDTaMQE3elY8
         w5O8PfCk6uq3IxkLiItUovmV3E9B3t7k8YTqDJNTUzvE3QmIVlazOZtFX9DGsz+saO
         oqHxh1X4fUyAivxdkFdaJLBSaSsr+TX4XAsW/6YA=
Date:   Fri, 11 Aug 2023 21:25:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org
Subject: Re: [GIT PULL] FSI changes for v6.6
Message-ID: <2023081159-revered-leggings-e661@gregkh>
References: <CACPK8XfqHtYnzKy_beXRXTuK5MNzu2Fp2K8mr2fUBBD5VgsKaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfqHtYnzKy_beXRXTuK5MNzu2Fp2K8mr2fUBBD5VgsKaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 08:15:39AM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> Please pull these FSI changes for v6.6.
> 
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.6

Pulled and pushed out, thanks.

greg k-h
