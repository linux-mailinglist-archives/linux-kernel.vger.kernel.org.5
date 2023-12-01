Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226B58009EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378528AbjLAL2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378534AbjLAL2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C629C4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:28:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC2C433C7;
        Fri,  1 Dec 2023 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701430123;
        bh=+CY200c3P1YcHMz2FxX9L2fRqDJFDDZBDh06i6l/aQg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=ScQkbjnlsg/m/synO6lDG8Ur9wOgfWoOeDvYL8FThGl1xsaWwLYiIPOQdCVrfgd10
         bkdC5kfJRTHNyH4uG6wENK0StoawoazIt+4xAivegQO+hSzcox1hG+QsZdJMg5EdLt
         g3r/RbB+3KOoJTGZw0+0eXXFelN6H+RCFQ4JrgqSg3YSzqagUTyy34KYeNTXOZrNbV
         uh6JhEXvswMtadA9ShxddHkOck7JPexVCofwOmLjeDDXMxh1sYxHHSKPJVDnfVYAQO
         AsU/3QWf5zaVN6e6z+113C1i/pCfh8IdGCT/RJGDWB8Mx/56TZIO5R7cOmZJ7yY3NJ
         7fImdCAjEmBdw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20231130115712.669180-2-ckeepax@opensource.cirrus.com>
References: <20231130115712.669180-1-ckeepax@opensource.cirrus.com>
 <20231130115712.669180-2-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 2/2] mfd: cs42l43: Correct order of include
 files to be alphabetical
Message-Id: <170143012194.3372684.17160774637056750359.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 11:28:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 11:57:12 +0000, Charles Keepax wrote:
> 


Applied, thanks!

[2/2] mfd: cs42l43: Correct order of include files to be alphabetical
      commit: c09588105fc8d26d9b63a699c705fec4ac2ca379

--
Lee Jones [李琼斯]

