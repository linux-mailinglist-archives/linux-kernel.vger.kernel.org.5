Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4891800412
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377617AbjLAGlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAGla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:41:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73651711
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:41:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8670C433C7;
        Fri,  1 Dec 2023 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701412896;
        bh=wBxRNgktqMi4buSak8ExlObqOhD8lf2YOCeG4b9vF2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDfX/szat7TYKUyWdJ87XILl5vFTSxT6f5q1oUgSgxwS/JcQu7kDqjzs9HbN2RrBj
         Q4PnH8BnlgFQSyqFjv1hc+qlPiSLEQK65b4zaT1XJSA8p5zuwAnL9EFzjn54kPyjVh
         rfGbOpTGtPGuyGN0d8Msjq5QhBAhGDhiaJRpXMqMh8JUsY/jiMgXz7l0J8npoBvljh
         V518EprIKwKqRoyKjG2Q3nKMjcOF6XRC3ocouCwaO486pk2hOH9hiVfQ/nmu35ngK9
         wxjapoTCEOUa3X+LLQyBo0frJgFFUCSz4Cd2ynPua3XjamiNbd9vDGRWdn8NK4jjpE
         B77/VUT25b+yw==
Date:   Thu, 30 Nov 2023 22:41:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <20231130224134.73652d71@kernel.org>
In-Reply-To: <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
        <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 13:59:48 -0800 Kees Cook wrote:
> [1/1] net: ena: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/111f5a435d33

Again, please drop, Arthur requested for the commit message
to be changed.
