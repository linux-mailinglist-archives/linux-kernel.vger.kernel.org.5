Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4590E805BB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346077AbjLEPQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbjLEPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9B1BA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:16:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378F5C433C7;
        Tue,  5 Dec 2023 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789412;
        bh=QQEeFGL7yK2IXN7MsYq3QwzQUqgC71GBc4pjC7Vq4YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h5P9Gv/eqMFvoeKPy1zfulKCr/k32T0jTJcMAGAYwdRwdgC9RQrqnNQ88lNuFXGJL
         fFaySrDLJM9kBK8FlC5Ez4rwkL5E5kZ4hBJPmLg7vNej1LE5XoO41ScPMOR0e2djnB
         tNHHDSJULQdEPNmSw92sTTHOmh3+ON4WxF+0IJ431TvXzQencFH/R6tzl0du7JfdJO
         XPFs9QcyfC9ye1MoV9fsm0BQ81gTet3AGuf7i+cmKQB7XJ86l10qFLy4btimDxO0V7
         KX80mPbKn0tmyfjvJsQGuixufvtFUgS4PIEkokf/Ye8fAWXU3RMPIhOMuTETJddNa/
         2l20oNLbBWRIQ==
From:   Will Deacon <will@kernel.org>
To:     jonathan.cameron@huawei.com, Junhao He <hejunhao3@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        yangyicong@huawei.com, prime.zeng@hisilicon.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers/perf: hisi: Fix some event id for HiSilicon UC pmu
Date:   Tue,  5 Dec 2023 15:16:29 +0000
Message-Id: <170177974197.1060739.15417624024644371225.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231204110425.20354-1-hejunhao3@huawei.com>
References: <20231204110425.20354-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 19:04:25 +0800, Junhao He wrote:
> Some event id of HiSilicon uncore UC PMU driver is incorrect, fix them.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: Fix some event id for HiSilicon UC pmu
      https://git.kernel.org/will/c/38bbef7240b8

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
