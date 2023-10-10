Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61597C48DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 06:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbjJKEdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 00:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjJKEdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 00:33:00 -0400
X-Greylist: delayed 28521 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 21:32:57 PDT
Received: from a3.inr.ru (b133.inr.ru [185.207.89.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC529E;
        Tue, 10 Oct 2023 21:32:57 -0700 (PDT)
Received: from al20.localdomain ([172.20.74.5] helo=al20.inr.ru)
        by a3.inr.ru with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <durkinap@inr.ru>)
        id 1qqJRj-0023LT-1k;
        Tue, 10 Oct 2023 23:35:15 +0300
Received: from localhost ([::1] helo=rcmail.inr.ru)
        by al20.inr.ru with esmtp (Exim 4.92)
        (envelope-from <durkinap@inr.ru>)
        id 1qqJRj-0005ZT-8S; Tue, 10 Oct 2023 23:35:15 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Oct 2023 21:35:15 +0100
From:   Rowell Hambrick <durkinap@inr.ru>
To:     undisclosed-recipients:;
Reply-To: rowellhambrick019@gmail.com
User-Agent: Roundcube Webmail/1.4.2
Message-ID: <533a85469df4dd5d88408740e4689865@inr.ru>
X-Sender: durkinap@inr.ru
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: durkinap@inr.ru
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: ****
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on al20.inr.ru)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you get my previous mail
