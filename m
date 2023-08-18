Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6667807DE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358942AbjHRJDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358918AbjHRJCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:02:30 -0400
X-Greylist: delayed 1475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:02:02 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF0422F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 02:02:02 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 4CFFB84846; Fri, 18 Aug 2023 09:16:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346613; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=JHsxK9tnBxiDC9w3XXiHaweV80YhKy5vqAgVwkU50bHP+76VGCCT44eXdbsEFhyME
         W4n3uPDitE/snEL5r3+v0aUINFpWkh1uaz54qjQPIupBLln1eTGytnRsPWUe6Wc7RS
         UsNE/W8NcWAHPMTw1gl07TMZSEouCHwr98oht+Osou9b6eD6uPBkt/HeoXOuGowRPU
         zwBcTlQJV+/yIURKKDq4T3EHSYfnT1CwMb+ntxicO/9sx9U9DW1qMC/Xjr5CkfX9Uw
         iFWLYcPIl5e+TUK3B6XmcUBJyVWH+AZnIAw+9fzrIv4xZF+UVsfmiGLLvezSZrJWtL
         HfCP/KifCMuCg==
Received: by mail.leachkin.pl for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cufa.0.kg2ncqnr8f@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
