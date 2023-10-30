Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442E7DB406
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJ3HUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJ3HUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:20:15 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D160BD9;
        Mon, 30 Oct 2023 00:20:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qxMYU-003I9D-Ug; Mon, 30 Oct 2023 08:19:22 +0100
Received: from p5dc55299.dip0.t-ipconnect.de ([93.197.82.153] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qxMYU-003Lqt-Lh; Mon, 30 Oct 2023 08:19:22 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
        (envelope-from <glaubitz@physik.fu-berlin.de>)
        id 1qxMYU-000ydU-0h;
        Mon, 30 Oct 2023 08:19:22 +0100
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     arnd@kernel.org
Cc:     Larry.Finger@lwfinger.net, alexandre.belloni@bootlin.com,
        arnd@arndb.de, claudiu.beznea@tuxon.dev, davem@davemloft.net,
        geert@linux-m68k.org, geoff@infradead.org,
        gregkh@linuxfoundation.org, gregory.greenman@intel.com,
        johannes@sipsolutions.net, kuba@kernel.org, kvalo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nicolas.ferre@microchip.com,
        pavel@ucw.cz, quic_jjohnson@quicinc.com, stf_xl@wp.pl
Subject: Re: [PATCH 00/10] Remove obsolete and orphaned wifi drivers
Date:   Mon, 30 Oct 2023 08:19:22 +0100
Message-Id: <20231030071922.233080-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231023131953.2876682-1-arnd@kernel.org>
References: <20231023131953.2876682-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 93.197.82.153
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

There is some non-x86 hardware like the Amiga that still uses PCMCIA-style networking
cards on machines like the A600 and A1200. So, unless these drivers are actually causing
problems, I would rather not see them go yet.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
