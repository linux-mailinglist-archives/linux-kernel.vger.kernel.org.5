Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6479DB18
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 23:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjILVpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 17:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:45:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2E910CC;
        Tue, 12 Sep 2023 14:45:30 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DD8B660731A;
        Tue, 12 Sep 2023 22:45:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694555128;
        bh=3Y0Jvwq+cg/aK1R2TKVahHhA5BmB04GIQk37IYZYKYU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=do8M4cjsKczj60yxWoOJ2PfJs85vDSHfQ4bI1huvcuvWTgY9939U6N7cJzxYfJk+z
         KHd6SzsCPJ6Rp5usdBsNgwavhTkSN0U+3veT1gyC/HV0elRbUi2WjgJ4AvnVB49K0h
         2yGXnaESDp6OiJ3n3vLNFfY60F1Bk3NApnB3kn437O3GPYCLfNIXGY5pNS6T4MHPC0
         2BXq93/CWL4PG+OGRRq7fscLdF+06oPI7xexGHB1iybJohaDsnPcqIFf+7ksgIIm+j
         XX6ywF9/qqODlfKxlD/DAvXOiX/TC38VrYuea1ZFeIBkYEH1Si0K478ZF0yhPffBIv
         3z2EH1q3/sWbw==
Received: by mercury (Postfix, from userid 1000)
        id 25AE1106098A; Tue, 12 Sep 2023 23:45:25 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
References: <20230902200518.91585-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 0/2] Match data improvements for bq2515x driver
Message-Id: <169455512513.524623.9779930015685182260.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 23:45:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 02 Sep 2023 21:05:16 +0100, Biju Das wrote:
> This patch series aims to add match data improvements for bq2515x driver.
> 
> This patch series is only compile tested.
> 
> Biju Das (2):
>   power: supply: bq2515x: Simpilfy bq2515x_read_properties() and probe()
>   power: supply: bq2515x: Some cleanups
> 
> [...]

Applied, thanks!

[1/2] power: supply: bq2515x: Simpilfy bq2515x_read_properties() and probe()
      commit: ef2730fb8122ff90747ee79261c2a9fd35032e17
[2/2] power: supply: bq2515x: Some cleanups
      commit: ab907d99d5d4e40ba638b6a27940d59fcb2ad24d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

