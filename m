Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F2791C0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244957AbjIDRdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjIDRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8B8CE0;
        Mon,  4 Sep 2023 10:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38FB3617A3;
        Mon,  4 Sep 2023 17:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D412C433C8;
        Mon,  4 Sep 2023 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693848785;
        bh=rkY6v9GzdFQhAiefCv29e5BonbUyvzaJogJ1bqtwFAE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RWB6Ylfjv+HT9ih0gBE52vTj6Rt/JXzACv6TQPxx9+rAtMPbMrenW/JSROZcxnA+U
         8MSg76zFX4Owkzsk44rebivpj+UQcv5mS42LJVsmf3zfbl8M+a/9uCrUumEkeSolow
         zWgB6ybNzoN8tBoXktQZgb210UBgLGFgj/JL4ZzWrhdeyZzeTMMAs1/koH1prQnRV0
         1t7MgJh8ahDKwqpuBhihY8l9zT+snyXqpBW1I3Z13CmyCgnrqqTVBfA8HRXKGs42zP
         AL7aW/cw0F1QLDz5hIENdAXo0PRjQbuXtKlK0RI8wo5+eU4VRTfPldUMRQnM3UR2gK
         9eMAPMeXCG/Pg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: mark TOTOLINK N150UA V5/N150UA-B as
 tested
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230829074358.14795-1-zenmchen@gmail.com>
References: <20230829074358.14795-1-zenmchen@gmail.com>
To:     Zenm Chen <zenmchen@gmail.com>
Cc:     Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zenm Chen <zenmchen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384878264.3484948.12611567607635849171.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:33:04 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zenm Chen <zenmchen@gmail.com> wrote:

> TOTOLINK N150UA V5/N150UA-B (VID=0x0bda, PID=0x2005) works fine with
> the rtl8xxxu driver, so mark as tested.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Patch applied to wireless-next.git, thanks.

e55c486c9b05 wifi: rtl8xxxu: mark TOTOLINK N150UA V5/N150UA-B as tested

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230829074358.14795-1-zenmchen@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

