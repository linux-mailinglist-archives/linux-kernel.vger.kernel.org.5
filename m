Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331E579D64C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbjILQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbjILQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:28:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740801725;
        Tue, 12 Sep 2023 09:28:41 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-163.ewe-ip-backbone.de [91.248.213.163])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81D9A6607321;
        Tue, 12 Sep 2023 17:28:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694536120;
        bh=22mYHr8LRfVBST7lgkFnWwa/P75qRW5aTFi3xiR3Fsg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=h0ilXMbEPz3ajHEd8pMsbqm+O8vgV9isC5xo+anuE9xHIs+rk85l2xSfUrOwJnBxX
         0ft2qvGi8fYHFoBir26ODydgUH7l6tWYnXC5blMZoVHrnaJQi0ONnp5nbjRVFWY1LL
         0EKQph+PbFn31LXHPtGT/jTU6WZ9tObN8HiUQAaDoTipZz+5Q2kuM0Z4bpg1SiuRiR
         VOt57RyttHzKjr2Qs+9gAyo89cShNSebPF61x7lH/os4j7NDWYoAnZdYHXcnb7l2B8
         9WcxZ+PWC86+nG2Jr5jYFRKDFBbVarU15rSIdrewYhjSWUdgORGnmk8QFG9X/DfCOJ
         5WEh/UJF51YeA==
Received: by mercury (Postfix, from userid 1000)
        id 7E2FB106098A; Tue, 12 Sep 2023 18:28:37 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230831171235.58477-1-biju.das.jz@bp.renesas.com>
References: <20230831171235.58477-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v3] power: supply: sbs-battery: Make similar OF and ID
 table
Message-Id: <169453611747.465135.10535963315035318047.b4-ty@collabora.com>
Date:   Tue, 12 Sep 2023 18:28:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Aug 2023 18:12:35 +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match
> using i2c_match_data(). Currently it works only for OF match
> tables as the field is wrong for ID match.
> 
> 

Applied, thanks!

[1/1] power: supply: sbs-battery: Make similar OF and ID table
      commit: a7d79bcc8364483b0d39c944d72b425cf06eccc5

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

