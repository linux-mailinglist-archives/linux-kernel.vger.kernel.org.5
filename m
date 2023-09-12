Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40D379DB2A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjILVxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjILVxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:53:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCC110CC;
        Tue, 12 Sep 2023 14:53:02 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3530D660731A;
        Tue, 12 Sep 2023 22:53:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694555581;
        bh=HNrzzFTWzQ4cDQWYcCwAmqtp8qqc0ZCAEHrFYUaaL9k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bBI9i7VpNkzfjAChktw4w6dPFuuV9X5fqnfEILMtY97XVCunNZGUjCwhW94r5RW/X
         ShQarwWN4hwiEb/0o7Q599zX5cS4kitm0gdasEzKlQWw68U4aLyY/7P1OoimVTQq9y
         AvDDk8ZKjGcS7Az7YGfcPwGlIa0oSyaW6K5WNl3A24L4tH6JJ3/Upsn68K/8j62KXG
         ScpjY35KGVHqgYDaZFQAwV3p9vcBmrD3D3vGITArzf3OkDXtiluC/MHo81WmgMqgL7
         iQaPu6Ic2N3CPlpIxwBxwiE1FjH+CDveEgZx3LAyRk2pzfOdpjH1GlL94aDKdIKowv
         9+LqsTtjLSqwg==
Received: by mercury (Postfix, from userid 1000)
        id 96231106098A; Tue, 12 Sep 2023 23:52:58 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
References: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] Match data improvements for bq24257_charger driver
Message-Id: <169455557856.528406.9378433904622873998.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 23:52:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 02 Sep 2023 20:33:29 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for bq24257_charger
> driver.
> 
> This patch series is only compile tested.
> 
> Biju Das (2):
>   power: supply: bq24257_charger: Make chip type and name in sync
>   power: supply: bq24257_charger: Some cleanups
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq24257_charger: Make chip type and name in sync
      commit: 3dc4a291a1b156d3ee9a78672ec950601bd68c1c
[2/2] power: supply: bq24257_charger: Some cleanups
      commit: b92f5e4fccc2ca96241904bb1a4e96547b69163d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

