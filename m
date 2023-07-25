Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69EE761CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGYPIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjGYPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B7F1BD9;
        Tue, 25 Jul 2023 08:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECA461782;
        Tue, 25 Jul 2023 15:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13C1C433C7;
        Tue, 25 Jul 2023 15:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690297697;
        bh=VHzZBfClV+CNBXI3k/TmwtmonxPtF4iy+Fia4vkQRg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9Fd0SPExSJ2+zD3OHifU2/C1+e3ZLbbcnmSi241PonXIELMObVovdOIp1XRFInkA
         WB7w91nraCHDdJHxxAauqcr88Hb30mpgp9tnfZAFH0EeODaaP1G0GamIkHbJ996adm
         7latGs4aCkO574H5+MEiCMKxJf9q3zfq1rFi3PUQ=
Date:   Tue, 25 Jul 2023 17:08:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.5-rc4
Message-ID: <2023072506-smokeless-doorway-bab3@gregkh>
References: <ZL_VnZUGvlOlLKAy@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL_VnZUGvlOlLKAy@hovoldconsulting.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 04:01:01PM +0200, Johan Hovold wrote:
> The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:
> 
>   Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.5-rc4

Pulled and pushed out, thanks.

greg k-h
