Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC97F9B48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjK0IGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 03:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjK0IGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:06:22 -0500
X-Greylist: delayed 1099 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Nov 2023 00:06:24 PST
Received: from email.solokkota.go.id (unknown [103.84.209.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CED113;
        Mon, 27 Nov 2023 00:06:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by email.solokkota.go.id (Postfix) with ESMTP id 77A6B31E69D6;
        Mon, 27 Nov 2023 07:37:42 +0000 (UTC)
Received: from email.solokkota.go.id ([127.0.0.1])
 by localhost (email.solokkota.go.id [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 2gALIKvXUDpk; Mon, 27 Nov 2023 07:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by email.solokkota.go.id (Postfix) with ESMTP id BE25E31E6849;
        Mon, 27 Nov 2023 07:37:40 +0000 (UTC)
X-Virus-Scanned: amavis at email.solokkota.go.id
Received: from email.solokkota.go.id ([127.0.0.1])
 by localhost (email.solokkota.go.id [127.0.0.1]) (amavis, port 10026)
 with ESMTP id aMcxEjzFzayS; Mon, 27 Nov 2023 07:37:40 +0000 (UTC)
Received: from email.solokkota.go.id (email.solokkota.go.id [103.84.209.203])
        by email.solokkota.go.id (Postfix) with ESMTP id E450D31E685E;
        Mon, 27 Nov 2023 07:37:35 +0000 (UTC)
Date:   Mon, 27 Nov 2023 07:37:35 +0000 (UTC)
From:   =?utf-8?B?0KHQuNGB0YLQtdC80L3Ri9C5INCw0LTQvNC40L3QuNGB0YLRgNCw0YLQvtGA?= 
        <bkpsdm@solokkota.go.id>
Reply-To: "sistemassadmins@mail2engineer.com" 
          <sistemassadmins@mail2engineer.com>
Message-ID: <2012526249.53383.1701070655898.JavaMail.zimbra@solokkota.go.id>
Subject: 
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Originating-IP: [103.84.209.203]
X-Mailer: Zimbra 8.8.15_GA_4562 (zclient/8.8.15_GA_4562)
Thread-Index: G+DS06TjlopQ5zHxI83iTmQ3DgACBQ==
Thread-Topic: 
Content-Transfer-Encoding: 8BIT
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_REPLYTO,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,REPLYTO_WITHOUT_TO_CC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [103.84.209.203 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [103.84.209.203 listed in bl.score.senderscore.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ВНИМАНИЕ;

Ваш почтовый ящик превысил ограничение хранилища, которое составляет 5 ГБ, как определено администратором, который в настоящее время работает на 10,9 ГБ, вы не сможете отправлять или получать новую почту до тех пор, пока не проверите почту почтового ящика повторно. Чтобы повторно проверить свой почтовый ящик, отправьте следующую информацию ниже:

имя:
Имя пользователя:
пароль:
Подтвердите пароль:
Электронная почта:
Телефон:

Если вы не можете повторно проверить свой почтовый ящик, ваш почтовый ящик будет отключен!

Приносим извинения за неудобства.
Проверочный код: en: WEB. АДМИНИСТРАТОРА. RU006,524765 @2023 Почтовая техническая поддержка @2023

Спасибо
Системный администратор.
