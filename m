Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B554779DE49
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjIMC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjIMC3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:29:01 -0400
Received: from smtp1.hiworks.co.kr (smtp1.hiworks.co.kr [121.254.168.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7BD1713
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 19:28:55 -0700 (PDT)
Received: (qmail 84872 invoked from network); 13 Sep 2023 11:28:50 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.180)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 11:28:50 +0900
Received: (qmail 163461 invoked from network); 13 Sep 2023 11:28:50 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        13 Sep 2023 11:28:50 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913112850_3679163100>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, fido_max@inbox.ru,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, mwkim@gaonchips.com, perex@perex.cz,
        tiwai@suse.com, u.kleine-koenig@pengutronix.de,
        xingyu.wu@starfivetech.com
Subject: Re: [PATCH] ASoC: dwc: fix typo in comment
Date:   Wed, 13 Sep 2023 11:28:15 +0900
Message-Id: <20230913022815.1446867-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZQBoyKulheGf8h/e@finisterre.sirena.org.uk>
References: <ZQBoyKulheGf8h/e@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This doesn't apply against current code, please check and resend:

Sorry, I will send a clean v2 in a moment.

