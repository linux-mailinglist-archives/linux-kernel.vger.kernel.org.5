Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787DB7D4CC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjJXJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjJXJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:42:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BFEC2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:42:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48BDC433C8;
        Tue, 24 Oct 2023 09:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698140559;
        bh=9oklU2sgIPdhg197uemsXfWQY+HVG4t3da0358w+iDU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=jDNue9WKlEw3PXvRsxfZSwJD5JJayxhWt0e1BnYpenvbyGXv08zQZa2W4e26mZLRr
         zFTSkYbXZzyQTEzuILbSujKuLpTZtbcqDr7dZj8F7aYHzdrntHbPFrSGVtG5iyrsHg
         NzhGHsPyn7c7XD3Uo0+en4S1NKbUsXRXOR8b5n3x2rzbSBccFWbdJrWsarNTCt5LvM
         0Mz9OQEh5Q0Dykn0io9rvNSEI+ijgVlg5h9w6TPjmZqKN94JdUin+Fz/sb/FgB5nWs
         WGZOW2VZRV+71wUI1MoQvfxvoKo3oe5LxqgIrulFiXVkV003ZuRpaFDVBTk1BfjF80
         Qj3OW3xWcMV2g==
From:   Maxime Ripard <mripard@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        Emma Anholt <emma@anholt.net>, Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
References: <20231023085929.1445594-1-dario.binacchi@amarulasolutions.com>
Subject: Re: (subset) [PATCH] drm/vc4: fix typo
Message-Id: <169807119062.131218.9254830713560666523.b4-ty@kernel.org>
Date:   Mon, 23 Oct 2023 16:26:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 10:59:20 +0200, Dario Binacchi wrote:
> Replace 'pack' with 'back'.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

