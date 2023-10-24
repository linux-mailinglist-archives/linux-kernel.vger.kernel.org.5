Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33FF7D5725
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjJXP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343746AbjJXP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:59:30 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7283
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1698163166; bh=7wKiMvz48EEme5AGQCCYQvWLJkeEXaDFdEDgDikUtq0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BhiU+6WxhQQsFkyaNeccNUGfv59OTdS4vSDACQLw4cLnFZvUFuiUd8PNrs3k5iPim
         615b6waNmpE1i+d8m43rOmHiiZeEFls6SSGWcHGwjcSVx7d1DzYrRqhlXS98Vb5M8u
         6AD1UHbaUn66Mspkuu3xluuv8B7u6NFaqZOVa71k=
Date:   Tue, 24 Oct 2023 17:59:13 +0200 (GMT+02:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Message-ID: <d5d7dcdf-11d7-4bfb-9aeb-c440394ddfc4@t-8ch.de>
In-Reply-To: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
References: <20231023-nolibc-waitpid-flags-v2-1-b09d096f091f@kernel.org>
Subject: Re: [PATCH v2] tools/nolibc: Use linux/wait.h rather than
 duplicating it
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d5d7dcdf-11d7-4bfb-9aeb-c440394ddfc4@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Oct 23, 2023 20:42:52 Mark Brown <broonie@kernel.org>:

> Linux defines a few custom flags for waitpid() which aren't currently
> provided by nolibc, make them available to nolibc based programs by just
> including linux/wait.h where they are defined instead of defining our
> own copy of the flags.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

I can apply it, but only next week.

Thomas
