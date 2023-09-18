Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68217A5042
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjIRRC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjIRRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24C8E;
        Mon, 18 Sep 2023 10:02:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA83BC32787;
        Mon, 18 Sep 2023 14:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047481;
        bh=8oCZ0wBkKK+50M3k5DKRDIJ4/8F2UdDzIsVH6iEwnDU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q0HSu1mkH+tqCarz8XJQILDF0F7Cpv+omuE1ZWFQZBqZLXDQGmFmUdvA0ccbQ1RTt
         E2hwHERWSLnqrYiR9wwYEG89jE93w7MttaPOFRUfU+S1DW3X3oohzE1NDsS5/VJQsI
         zBxxWreZXnyHPEhITnKm90q2UkZcaG3TWqn1tYtSqDzuAxtmbpIAvMDOiEWI8qgeOG
         boIOqfwM9JuB6+4A/28x4lGCNG22LK2hNd8TdEuiyD2pEkXWXBXE2sIQR61hBLAlrr
         5+ntj11EvUXkzHg0teX2xqoKkCx4d6IOSiFsUaAqBI0F0O6x2Y8rkKF/fKNQrL+0fP
         bQx3h4Y2Cf7Ug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: Add a description about the device ID
 0x7392:0xb722
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230912053614.10644-1-zenmchen@gmail.com>
References: <20230912053614.10644-1-zenmchen@gmail.com>
To:     Zenm Chen <zenmchen@gmail.com>
Cc:     Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, rtl8821cerfe2@gmail.com,
        Zenm Chen <zenmchen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504747757.740666.11200624028934392804.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 14:31:19 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zenm Chen <zenmchen@gmail.com> wrote:

> According to the driver provided by EDIMAX, the device ID
> 0x7392:0xb722 belongs to EDIMAX EW-7722UTn V3, so add a comment about this.
> 
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Patch applied to wireless-next.git, thanks.

c35642806830 wifi: rtl8xxxu: Add a description about the device ID 0x7392:0xb722

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230912053614.10644-1-zenmchen@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

