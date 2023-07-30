Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75317686BC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjG3R1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjG3R1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05519AB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B559060C98
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 17:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA480C433C7;
        Sun, 30 Jul 2023 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690738054;
        bh=pSLYxgMjwsGIgcCwKb7HOuT3xdHzNFwyOhdX3x7XHrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmb6tDcQrmRFhG2MRo3nSOVrKjYAy0oUromdbic6c3fB95B9NxNxgQrGQ+bowdvlp
         wbPVBtojvNmMTTxyckdNsM16gHjkqoaA8Poqn1tsKvPC0PB/N137NguOJWmwwt8AW/
         x+HDVMje5A9mf5tXxc+P0GfaCSiM/SFw3+ouGseao0qNtDjnYMfFOWdizNQ1miYT+Z
         ANm7h8d6whgmOavC080lhiBVojelsK0ApUdDJx1CU/N5+gEKBxv/ETT5ZD7FBiTGG4
         QfCVyGycae+EzVJMll/IuuhRdvIznbxMzYKAXiKIqpXyYv08b/XoceShfhxf/DSVdJ
         fRKoFsf7JkRIg==
Date:   Sun, 30 Jul 2023 19:27:29 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     bryantan@vmware.com, vdasa@vmware.com, pv-drivers@vmware.com,
        sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] vsock: Remove unused function declarations
Message-ID: <ZMadgRSXLJXbrbu5@kernel.org>
References: <20230729122036.32988-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122036.32988-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:20:36PM +0800, Yue Haibing wrote:
> These are never implemented since introduction in
> commit d021c344051a ("VSOCK: Introduce VM Sockets")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

