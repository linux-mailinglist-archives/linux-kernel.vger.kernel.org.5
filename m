Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D061779198
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjHKOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjHKOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CB2709;
        Fri, 11 Aug 2023 07:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29710671E0;
        Fri, 11 Aug 2023 14:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C64C433C8;
        Fri, 11 Aug 2023 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691763393;
        bh=xUaIipfe7EEka0iG4bmlAwssUXHE12R1fRkK5NvSwoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMCKQq9xPIscO5qJd3HZcuqGxgGiVLX6Gm9fSCor9zXSysl6LHlSaiICGg5ZykqQ9
         jkIILbTICBCKrnc2lpSb66LHK1Be+0OGYfK50Of+4dfd8x1v6Z1LkffQl6wCXOSSOB
         xJ3AF/4OfoKuLVXDgrRHa0f9OpxWf+sZtcqFERvg=
Date:   Fri, 11 Aug 2023 16:16:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ronald Warsow <rwarsow@gmx.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.4 000/165] 6.4.10-rc1 review
Message-ID: <2023081155-geometry-gloss-ab63@gregkh>
References: <5bba262f-c3a4-fdc0-deff-da3cb0dc49e4@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bba262f-c3a4-fdc0-deff-da3cb0dc49e4@gmx.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:40:48PM +0200, Ronald Warsow wrote:
> Hi Greg
> 
> 6.4.10-rc1
> 
> compiles [1], boots and runs here on x86_64
> (Intel Rocket Lake, i5-11400)
> 
> [1]
> But I'm unable to compile vbox external modules anymore
> seems to be a regression against Kernel 6.4.9

Please contact the vbox developers, that's up to them, they have to live
with the pain of wanting to keep out-of-tree drivers.

good luck, and thanks for testing!

greg k-h
