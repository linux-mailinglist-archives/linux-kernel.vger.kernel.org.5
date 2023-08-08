Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086E2773FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjHHQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjHHQxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:39 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C41BCA;
        Tue,  8 Aug 2023 08:58:43 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1691501451; bh=W8bIdKD5mKfiWkoL5WEwoDR8rszq9h4WfvWk0o4CimM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=i5Z71LN/lvQ2zoqudzblM2/X+CDt2dGrNBtDre3AbjhZmrDVM35zu9hOBluw1Cc54
         Zzity4WezzAge7NaoLls0TbZHh08eUaj9HnI6b7IfddaC9IetR99lbd0C08GdYaiyJ
         oCSchCv01+ldPW/pRAxuFa0eSb1Q+PeebetEfWnziEQW/tGJfyym6038uCjKJGX+Z3
         tMEGsZXo/7iWewS4ZOlBN/8Ti6LuAul+6BJLDmNyMiif6SWAs0J4Rg0v9UKRiB+F2V
         3Cv2l8il6eKbdP6xyh8I5nbi4/DDlvthHSf+v86PPvdQ0NuPaHsLe5NGniiuz4SF7f
         935hT9WEWpTlg==
To:     Minjie Du <duminjie@vivo.com>, Kalle Valo <kvalo@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH9K WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v1] net: wireless: ath9k: fix parameter check in
 ath9k_init_debug()
In-Reply-To: <20230712114740.13226-1-duminjie@vivo.com>
References: <20230712114740.13226-1-duminjie@vivo.com>
Date:   Tue, 08 Aug 2023 15:30:51 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87msz1br04.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minjie Du <duminjie@vivo.com> writes:

> Make IS_ERR() judge the debugfs_create_dir() function return
> in ath9k_init_debug()
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
