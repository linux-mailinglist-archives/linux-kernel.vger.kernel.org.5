Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EC7A67C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjISPOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbjISPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:14:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E142C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:14:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5700AC433C7;
        Tue, 19 Sep 2023 15:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695136480;
        bh=AAE03dwlccuCC1pZTXaFKK12HBSHImTlszkdY4aWUjE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=UlH1+Sq+rX1VTGqM4jWbvMzpABCD/jztTkSLojWfFXT5HZ/pNLTwsN2jjeUGaUaJf
         a8IS+6k18cFTSHAlUJX7kJzBVsNS8CZZmgvnVWwYqzbGGz/JHtOtlPOkUccy7mX/mW
         M+cjVJ4ICLIy4wpR3rdZjtcl/9lWgItLC6yFvpSoTyiPiNLpR86Gypn63p8xDRIo50
         OKRVxZqGAQrcVqOvtw6E3dSAhrjFn8awm7yFE2TUrkkq0/BaFdCvUmxRYa8S2o+4dJ
         jhtwY6VjMC+EsMrhXKwBKY/TbubLKVLCEh4CQA5rixDEdTzFZ22F99WLxJhCxZOcVK
         oJqHW8PBTp8/g==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <b73fe4bc4bd6ba1af90940a640ed65fe254c0408.1693253717.git.mirq-linux@rere.qmqm.pl>
References: <b73fe4bc4bd6ba1af90940a640ed65fe254c0408.1693253717.git.mirq-linux@rere.qmqm.pl>
Subject: Re: (subset) [PATCH v2] mfd: core: Un-constify mfd_cell.of_reg
Message-Id: <169513647909.3262131.4744372256931996439.b4-ty@kernel.org>
Date:   Tue, 19 Sep 2023 16:14:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:16:11 +0200, Michał Mirosław wrote:
> Enable dynamically filling in the whole mfd_cell structure. All other
> fields already allow that.
> 
> 

Applied, thanks!

[1/1] mfd: core: Un-constify mfd_cell.of_reg
      commit: ae20c605ad35baa3247a6e5d9c108fa9522155bd

--
Lee Jones [李琼斯]

