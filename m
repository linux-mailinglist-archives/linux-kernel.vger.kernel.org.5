Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368807CA420
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJPJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:28:44 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073F4B4;
        Mon, 16 Oct 2023 02:28:42 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63B2E2000A;
        Mon, 16 Oct 2023 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697448521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cB9YyJFPekauMqmT5IAfFQ+DrU/FcfXGDjW4V8YqQOQ=;
        b=ZmUG2+xx/8stKeIvalFYCjLGa0Vx4XxQo+/vbnIEaF4Nzqkq22FzfVZmpnt+OrwOkiV1QJ
        C24m9desM9hQpy+4l0VxMvxZjQFcmFO3tPOAQql+AOGWznNldzthNENtHf6aqUmn5lvTzl
        l/Z8sgAlWza+RiV5TaqDdAtp8wBUreQ9hfgmv2TTT5NHtN3ASy4TFuAKLgODrAuaTAhoz0
        eiStWnLxYCrGxKxyJ2HmbKNfA5UYOGLV+TxZ/40uWu+HtQLaiVBYtd5vR78BKpNkCGr4fI
        QuapSCnWa7Zh2GE85q1Gka7v0rLX3F8gYCxK+GDo2iPcwJXmnp4FvL8pAmUJDg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Simon Glass <sjg@chromium.org>, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Rob Herring <robh@kernel.org>, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nick Terrell <terrelln@fb.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mtd: fixed-partitions: Add compression property
Date:   Mon, 16 Oct 2023 11:28:36 +0200
Message-Id: <20231016092836.288939-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927180545.3522628-1-sjg@chromium.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8baba8d52ff5081e8c3c383132af269ba8e2f458'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 18:05:43 UTC, Simon Glass wrote:
> Sometimes the contents of a partition are compressed. Add a property to
> express this and define the algorithm used.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
