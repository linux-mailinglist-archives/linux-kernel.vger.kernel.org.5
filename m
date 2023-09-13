Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF00B79F30F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjIMUoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjIMUob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:44:31 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CAE1BCB;
        Wed, 13 Sep 2023 13:44:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64B88E0004;
        Wed, 13 Sep 2023 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694637865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2lbRiyY1HB20QiC/VpSIgvL43XC5QTz6Kf4M0hvMSg=;
        b=RX0eEPL1xkxYulHJ6Yz+0rj/AlbTsKrZlg9Md4eAUs+aZTei2EVUUj0w4A4QSoV31X1XD2
        bBfZhrI5/jiXYzMjmw9WJKaVlXUSqGxUzWWDbs/EvjkINo1Uj4Co4BiQmDalKodFhww/zb
        uBKWb2uXcaHmDGk3V+iQuoeIW9FuI04y3Ae1pOr7rXAneRMM+LsCgpPx2QnpnDDPxn0p2c
        qpOal/nqQO/Lptc1AL4KFV4Oei3sXdaCwzNnUjxqBFyF33tZJfaui+H/HDNpaVRPNOsgLX
        EDjbPteL2LuIXvuuwwZFqIzMzAFh9ocXeHHiTaRAH/9SlT0BVbP2vapDRy7cKw==
Date:   Wed, 13 Sep 2023 22:44:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ralph Siemsen <ralph.siemsen@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: renesas: r9a06g032: name anonymous structs
Message-ID: <20230913224422.237ef68c@xps-13>
In-Reply-To: <20230913203805.465780-2-ralph.siemsen@linaro.org>
References: <20230913203805.465780-1-ralph.siemsen@linaro.org>
        <20230913203805.465780-2-ralph.siemsen@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralph,

ralph.siemsen@linaro.org wrote on Wed, 13 Sep 2023 16:38:05 -0400:

> Clarify the content of the r9a06g032_clkdesc structure by naming the
> remaining anonymous structures defined inside. Renaming each field and
> updating the doc then becomes necessary in order to avoid name
> duplications and kdoc warnings.
>=20
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
