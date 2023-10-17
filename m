Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA087CCA37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343928AbjJQR6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjJQR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:58:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DAB83
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:58:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942BEC433C7;
        Tue, 17 Oct 2023 17:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697565496;
        bh=oGn9oh+6+yIrq6U2Mv2CNfp9n42N+Jh1J10p/IZvqj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wweHOLeFQd8fsj/gg30ewV5tEyYrikb7EFibi5bTf8m8bwkO7m9pHdyCIvl4kmcS5
         OxgqLhMnyt6z3OMcgHoaPVb4lqVaXBE9P4Xycg+fXNlz6EUPKepAlbrxQxtWJAseVn
         dxI2C9/SkCq6e/jl224lhG+TflhljqnRsem67Jf8=
Date:   Tue, 17 Oct 2023 13:58:15 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pgpkeys: use full keyid to trust Linus' key
Message-ID: <20231017-gutter-genre-e8cf4e@meerkat>
References: <20230716-keyid-v1-1-bf14426a8279@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230716-keyid-v1-1-bf14426a8279@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Jul 2023 21:42:36 +0200, Thomas Weißschuh wrote:
> It's possible for fingerprints to collide.
> To avoid that people accidentally trust an impersonated key document the
> full key fingerprint.
> 
> 

Applied, thanks!

[1/1] pgpkeys: use full keyid to trust Linus' key
      commit: 6b2c89700cabd7ff9b180beb7c81d75778eafafa

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>
