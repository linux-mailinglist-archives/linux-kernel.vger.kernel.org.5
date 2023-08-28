Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC89E78B83E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjH1T0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjH1T0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:26:12 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 12:26:08 PDT
Received: from symantec.comsats.net.pk (symantec.comsats.net.pk [210.56.11.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE782114
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:26:08 -0700 (PDT)
X-AuditID: d2380b23-3c1ff70000007104-7a-64ecf141a809
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 54.D7.28932.141FCE46; Tue, 29 Aug 2023 00:10:57 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=ZbvYrye8JqzBiND0uCgVmZeXrNNY/MIK3zbHN7TZxu6C/tZKGoyT3s1n7IwBLfTKp
          MolIuUexdxsbg/Nays48dvP2PW2nLWaDweJ2LyNp0WDXGVpY49RkW1jL9gnwXGXhU
          8+ruZCodfe2zk8cLeVOrFQDVFJvmgCmKceK9oO5IM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=olmk80cLmZoXHNEULi94oyNYNSuJDPnVFjLFsR7WPgY=;
        b=VhdTZbyt0QpNNV1SLb7IkERtHglHFw/YbiDHnBl996kM/Wsj4TJ4VkOiAjM4qdq6P
          QequdjcHCe4ZigioNDU6rG2SuK1Qew7ndFo0x3Mx4Rg6nVU8nNUXUfu/l6waFpfEU
          ub16jihEsb1hAqJ4T5rWr5r5Il1sUcEC5xcnYDEZ8=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Mon, 28 Aug 2023 23:58:45 +0500
Message-ID: <54.D7.28932.141FCE46@symantec.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Thanks for your response!
To:     linux-kernel@vger.kernel.org
From:   "Hou Qijun" <conference@iesco.com.pk>
Date:   Mon, 28 Aug 2023 11:59:05 -0700
Reply-To: qijunhou02@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTHvX1tebS88Xj8OnaAWnVZZuzcsuiyucX5j8tmZJkao9GMN/pG
        G0pb+17rYNHVuRisdgPXzq4D1m6ObINEQg3qCNhVKTgxmTCGOkUxgKHd6CaiEES8rz9o/7m5
        93Pu93vOvedekmCGSRWpNwqcxcga1HKFdGhzifLRHXdvaR+Ltmo2D19ukj+Fds52lu1Bryie
        1HIGvY2zrN9eodB975jIMncTB72nLmTZ0YTEgbJJoDeBp7FZKs4ZulsC7ouCAylIKd1GQMPd
        H2WJxTgBtwdiWeKCod9BYG8bQaKEorfA0f5RmTgnaA384HbJEzwPvjk1IU3wR6DVHyUciMTz
        NTDnEEScT6thqW8pvr2Avh8Czqm4jRxvD/juxKVS+mF43zcuE6UMXQb9XbYGlOvNSObNSObN
        SOZNJ/Mh6SVUzNfWsPjSKjWVphqeFXiNkRM05upOFL9B5YOfo3MN+0KIJpE6h6q339IyMtaG
        RSG0m5SoC6mbb2O0ar9JW6tjed0+i9XA8eoCaksEY2oF77caqtUqqmQU0/wVauTe4A2cgFsW
        QkASWDa0I4JlWra2jrOYEmYhtJqUqoupkjVTlQxdxQpcNceZOUsq+gJJqoG6OI2d8yxcFXfw
        gN4gpMJYF9wd1TJ0ZiReTCn1ch7OVZQZyKxHQmaH0E4yBxdVPimehTezNby+Kumbn6A5KRr3
        vJdqG8aQScG031VkIluOfdlDkPUzg3ic63IECUZqNBk5VTF1dAaraFGlsxpXalcVUeE+XGJu
        RkBMoyqhekVemMHTmVIvP4LmEe5ZPlUYE+vEHyNdPEN99xOGyiSM1w7U41HxCpMsbbixA/vQ
        7RIYC78EAz6vDL4O3ZTDfHCZhMCRxRxo/+TPIpjxeQDa26cBRr4Y3ADXJ3/ZBBP+ha3QdOWr
        Z2DZPrQL5uqnnoXORVc5HBvsexEuHJk+AJHoX2YYCzpt4Jl3vQmeO134EzWejL2HwN0c/gDB
        r4PXnAiuxzzHEdy+6v4Qwexy70cI/rkRxuPvfs9pBGcXepoRDI2MteDxcuBjFMGNk+DGuT4T
        XxMvsEJm45Q9EbFxSZpsnEyETAqmT6+yI/fptd2KP+qWFt+qWx8r+3YttTd29h5qb/e7fuf0
        uRuu8TM/T/77Wv9DvaX/HdrTuq5go7L29VWfPnC8xV/x9HOH6aAwlf3qrrxG43micuC+DucT
        VtfqGqsx9+/S2Hl9h+3Etq3Xxs5UqBcCz2+7Eu4e2V4+oGd/Gx0mDzlHO08c5i41zaqlvI7d
        sI6w8Oz/x+p7z+YEAAA=
X-Spam-Status: Yes, score=6.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [210.56.11.35 listed in list.dnswl.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [qijunhou02[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your response,


Kindly reconfirm your interest to further discuss the investment Thanks for=
 your response,


partnership within your country as I explained earlier so we can have a fur=
ther discussion to facilitate the process for mutual interest.

Looking forward to your response.

Hou Qijun
Vice President- CNPC
China National Petroleum Corporation
No. 9 Dongzhimen North Street Dongcheng District Beijing.

