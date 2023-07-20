Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4194675B92C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGTVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGTVDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:03:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21617271E;
        Thu, 20 Jul 2023 14:03:15 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KFkfJ5009054;
        Thu, 20 Jul 2023 21:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=qcppdkim1;
 bh=ArzehO3fCDSfspL6YrhcHeoMA4xNUv0kkNrMRzcrDIk=;
 b=FHCIWMXD5VQYpXTLsm/8OZlsq2Vfaxe4gp0As2M8BLAN6rv03YOt6ajr8qQIVtFPL13o
 3LWf0gBk9Zlj2OJRZvXZbo/+Rb+fXGfp5dA7Es4sDbSoks5vK40I1qEi5v/cHroyMbHI
 L7t6QTUq5oKIyTswXEWlJceF7amX6/aexJy6Eb8wTGNA3Ygdrgc0wcBwhmB30vxrk6aY
 lTB7FiiVKurnT75tm2T9GlVF+SknPKTbtzYQf/IdQP5T5MArxuE6qYH1MrW8iv8iOmne
 bVT9rS2m4dVNrNWZGofj8gSGA0oZfTkyhm3iQNIsSme8nLzFQvQ6/9npHicvKWw0+5Gr tQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxg3vbs32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 21:03:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KL32HI019409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 21:03:02 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 14:03:02 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] mailmap: Update remaining active codeaurora.org email addresses
Date:   Thu, 20 Jul 2023 14:02:56 -0700
Message-ID: <20230720210256.1296567-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 33Sv81_nfXTgQXUl9rSByCSSDO8PCFAS
X-Proofpoint-ORIG-GUID: 33Sv81_nfXTgQXUl9rSByCSSDO8PCFAS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307200178
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lack of mailmap updates for @codeaurora.org addresses reduces the
usefulness of tools such as get_maintainer.pl. Some recent (and
welcome!) additions has been made to improve the situation, this
concludes the effort.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 .mailmap | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 89b7f33cd330..9f067df9c306 100644
--- a/.mailmap
+++ b/.mailmap
@@ -13,7 +13,9 @@
 Aaron Durbin <adurbin@google.com>
 Abel Vesa <abelvesa@kernel.org> <abel.vesa@nxp.com>
 Abel Vesa <abelvesa@kernel.org> <abelvesa@gmail.com>
+Abhijeet Dharmapurikar <quic_adharmap@quicinc.com> <adharmap@codeaurora.org>
 Abhinav Kumar <quic_abhinavk@quicinc.com> <abhinavk@codeaurora.org>
+Ahmad Masri <quic_amasri@quicinc.com> <amasri@codeaurora.org>
 Adam Oldham <oldhamca@gmail.com>
 Adam Radford <aradford@gmail.com>
 Adriana Reus <adi.reus@gmail.com> <adriana.reus@intel.com>
@@ -30,6 +32,7 @@ Alexander Mikhalitsyn <alexander@mihalicyn.com> <alexander.mikhalitsyn@virtuozzo
 Alexander Mikhalitsyn <alexander@mihalicyn.com> <aleksandr.mikhalitsyn@canonical.com>
 Alexandre Belloni <alexandre.belloni@bootlin.com> <alexandre.belloni@free-electrons.com>
 Alexandre Ghiti <alex@ghiti.fr> <alexandre.ghiti@canonical.com>
+Alexei Avshalom Lazar <quic_ailizaro@quicinc.com> <ailizaro@codeaurora.org>
 Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
@@ -37,8 +40,11 @@ Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
 Alex Shi <alexs@kernel.org> <alex.shi@linux.alibaba.com>
+Aloka Dixit <quic_alokad@quicinc.com> <alokad@codeaurora.org>
 Al Viro <viro@ftp.linux.org.uk>
 Al Viro <viro@zenIV.linux.org.uk>
+Amit Blay <quic_ablay@quicinc.com> <ablay@codeaurora.org>
+Amit Nischal <quic_anischal@quicinc.com> <anischal@codeaurora.org>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
@@ -54,6 +60,8 @@ Andrey Ryabinin <ryabinin.a.a@gmail.com> <aryabinin@virtuozzo.com>
 Andrzej Hajda <andrzej.hajda@intel.com> <a.hajda@samsung.com>
 André Almeida <andrealmeid@igalia.com> <andrealmeid@collabora.com>
 Andy Adamson <andros@citi.umich.edu>
+Anilkumar Kolli <quic_akolli@quicinc.com> <akolli@codeaurora.org>
+Anirudh Ghayal <quic_aghayal@quicinc.com> <aghayal@codeaurora.org>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@bootlin.com>
 Antoine Tenart <atenart@kernel.org> <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
@@ -62,9 +70,17 @@ Archit Taneja <archit@ti.com>
 Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
+Arun Kumar Neelakantam <quic_aneela@quicinc.com> <aneela@codeaurora.org>
+Ashok Raj Nagarajan <quic_arnagara@quicinc.com> <arnagara@codeaurora.org>
+Ashwin Chaugule <quic_ashwinc@quicinc.com> <ashwinc@codeaurora.org>
+Asutosh Das <quic_asutoshd@quicinc.com> <asutoshd@codeaurora.org>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
+Avaneesh Kumar Dwivedi <quic_akdwived@quicinc.com> <akdwived@codeaurora.org>
 Axel Dyks <xl@xlsigned.net>
 Axel Lin <axel.lin@gmail.com>
+Balakrishna Godavarthi <quic_bgodavar@quicinc.com> <bgodavar@codeaurora.org>
+Banajit Goswami <quic_bgoswami@quicinc.com> <bgoswami@codeaurora.org>
+Baochen Qiang <quic_bqiang@quicinc.com> <bqiang@codeaurora.org>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@linaro.org>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@spreadtrum.com>
 Baolin Wang <baolin.wang@linux.alibaba.com> <baolin.wang@unisoc.com>
@@ -93,12 +109,15 @@ Brian Avery <b.avery@hp.com>
 Brian King <brking@us.ibm.com>
 Brian Silverman <bsilver16384@gmail.com> <brian.silverman@bluerivertech.com>
 Cai Huoqing <cai.huoqing@linux.dev> <caihuoqing@baidu.com>
+Can Guo <quic_cang@quicinc.com> <cang@codeaurora.org>
+Carl Huang <quic_cjhuang@quicinc.com> <cjhuang@codeaurora.org>
 Changbin Du <changbin.du@intel.com> <changbin.du@gmail.com>
 Changbin Du <changbin.du@intel.com> <changbin.du@intel.com>
 Chao Yu <chao@kernel.org> <chao2.yu@samsung.com>
 Chao Yu <chao@kernel.org> <yuchao0@huawei.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessm.com>
 Chris Chiu <chris.chiu@canonical.com> <chiu@endlessos.org>
+Chris Lew <quic_clew@quicinc.com> <clew@codeaurora.org>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntraeger@de.ibm.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <cborntra@de.ibm.com>
 Christian Borntraeger <borntraeger@linux.ibm.com> <borntrae@de.ibm.com>
@@ -119,7 +138,10 @@ Daniel Borkmann <daniel@iogearbox.net> <dborkmann@redhat.com>
 Daniel Borkmann <daniel@iogearbox.net> <dborkman@redhat.com>
 Daniel Borkmann <daniel@iogearbox.net> <dxchgb@gmail.com>
 David Brownell <david-b@pacbell.net>
+David Collins <quic_collinsd@quicinc.com> <collinsd@codeaurora.org>
 David Woodhouse <dwmw2@shinybook.infradead.org>
+Dedy Lansky <quic_dlansky@quicinc.com> <dlansky@codeaurora.org>
+Deepak Kumar Singh <quic_deesin@quicinc.com> <deesin@codeaurora.org>
 Dengcheng Zhu <dzhu@wavecomp.com> <dczhu@mips.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@gmail.com>
 Dengcheng Zhu <dzhu@wavecomp.com> <dengcheng.zhu@imgtec.com>
@@ -136,6 +158,7 @@ Dmitry Safonov <0x7f454c46@gmail.com> <dsafonov@virtuozzo.com>
 Domen Puncer <domen@coderock.org>
 Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
+Elliot Berman <quic_eberman@quicinc.com> <eberman@codeaurora.org>
 Enric Balletbo i Serra <eballetbo@kernel.org> <enric.balletbo@collabora.com>
 Enric Balletbo i Serra <eballetbo@kernel.org> <eballetbo@iseebcn.com>
 Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
@@ -148,6 +171,7 @@ Faith Ekstrand <faith.ekstrand@collabora.com> <jason.ekstrand@collabora.com>
 Felipe W Damasio <felipewd@terra.com.br>
 Felix Kuhling <fxkuehl@gmx.de>
 Felix Moeller <felix@derklecks.de>
+Fenglin Wu <quic_fenglinw@quicinc.com> <fenglinw@codeaurora.org>
 Filipe Lautert <filipe@icewall.org>
 Finn Thain <fthain@linux-m68k.org> <fthain@telegraphics.com.au>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
@@ -171,8 +195,11 @@ Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Gregory CLEMENT <gregory.clement@bootlin.com> <gregory.clement@free-electrons.com>
 Guilherme G. Piccoli <kernel@gpiccoli.net> <gpiccoli@linux.vnet.ibm.com>
 Guilherme G. Piccoli <kernel@gpiccoli.net> <gpiccoli@canonical.com>
+Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com> <gokulsri@codeaurora.org>
+Govindaraj Saminathan <quic_gsamin@quicinc.com> <gsamin@codeaurora.org>
 Guo Ren <guoren@kernel.org> <guoren@linux.alibaba.com>
 Guo Ren <guoren@kernel.org> <ren_guo@c-sky.com>
+Guru Das Srinagesh <quic_gurus@quicinc.com> <gurus@codeaurora.org>
 Gustavo Padovan <gustavo@las.ic.unicamp.br>
 Gustavo Padovan <padovan@profusion.mobi>
 Hanjun Guo <guohanjun@huawei.com> <hanjun.guo@linaro.org>
@@ -190,6 +217,7 @@ Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 J. Bruce Fields <bfields@fieldses.org> <bfields@redhat.com>
 J. Bruce Fields <bfields@fieldses.org> <bfields@citi.umich.edu>
 Jacob Shin <Jacob.Shin@amd.com>
+Jack Pham <quic_jackp@quicinc.com> <jackp@codeaurora.org>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk.kim@samsung.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
@@ -217,10 +245,12 @@ Jayachandran C <c.jayachandran@gmail.com> <jchandra@digeo.com>
 Jayachandran C <c.jayachandran@gmail.com> <jnair@caviumnetworks.com>
 <jean-philippe@linaro.org> <jean-philippe.brucker@arm.com>
 Jean Tourrilhes <jt@hpl.hp.com>
+Jeevan Shriram <quic_jshriram@quicinc.com> <jshriram@codeaurora.org>
 Jeff Garzik <jgarzik@pretzel.yyz.us>
 Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
 Jeff Layton <jlayton@kernel.org> <jlayton@primarydata.com>
 Jeff Layton <jlayton@kernel.org> <jlayton@redhat.com>
+Jeffrey Hugo <quic_jhugo@quicinc.com> <jhugo@codeaurora.org>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Axboe <axboe@kernel.dk> <axboe@fb.com>
@@ -228,6 +258,7 @@ Jens Axboe <axboe@kernel.dk> <axboe@meta.com>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 Jessica Zhang <quic_jesszhan@quicinc.com> <jesszhan@codeaurora.org>
+Jilai Wang <quic_jilaiw@quicinc.com> <jilaiw@codeaurora.org>
 Jiri Pirko <jiri@resnulli.us> <jiri@nvidia.com>
 Jiri Pirko <jiri@resnulli.us> <jiri@mellanox.com>
 Jiri Pirko <jiri@resnulli.us> <jpirko@redhat.com>
@@ -238,6 +269,7 @@ Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.cz>
 Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
 Jisheng Zhang <jszhang@kernel.org> <jszhang@marvell.com>
 Jisheng Zhang <jszhang@kernel.org> <Jisheng.Zhang@synaptics.com>
+Jishnu Prakash <quic_jprakash@quicinc.com> <jprakash@codeaurora.org>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Crispin <john@phrozen.org> <blogic@openwrt.org>
@@ -255,6 +287,7 @@ Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
 <josh@joshtriplett.org> <josht@vnet.ibm.com>
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@redhat.com>
 Josh Poimboeuf <jpoimboe@kernel.org> <jpoimboe@us.ibm.com>
+Jouni Malinen <quic_jouni@quicinc.com> <jouni@codeaurora.org>
 Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
@@ -262,6 +295,8 @@ Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
 Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
 Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
 Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
+Karthikeyan Periyasamy <quic_periyasa@quicinc.com> <periyasa@codeaurora.org>
+Kathiravan T <quic_kathirav@quicinc.com> <kathirav@codeaurora.org>
 Kay Sievers <kay.sievers@vrfy.org>
 Kees Cook <keescook@chromium.org> <kees.cook@canonical.com>
 Kees Cook <keescook@chromium.org> <keescook@google.com>
@@ -270,6 +305,8 @@ Kees Cook <keescook@chromium.org> <kees@ubuntu.com>
 Keith Busch <kbusch@kernel.org> <keith.busch@intel.com>
 Keith Busch <kbusch@kernel.org> <keith.busch@linux.intel.com>
 Kenneth W Chen <kenneth.w.chen@intel.com>
+Kenneth Westfield <quic_kwestfie@quicinc.com> <kwestfie@codeaurora.org>
+Kiran Gunda <quic_kgunda@quicinc.com> <kgunda@codeaurora.org>
 Kirill Tkhai <tkhai@ya.ru> <ktkhai@virtuozzo.com>
 Konstantin Khlebnikov <koct9i@gmail.com> <khlebnikov@yandex-team.ru>
 Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
@@ -278,6 +315,7 @@ Krishna Manikandan <quic_mkrishn@quicinc.com> <mkrishn@codeaurora.org>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski@samsung.com>
 Krzysztof Kozlowski <krzk@kernel.org> <krzysztof.kozlowski@canonical.com>
+Kshitiz Godara <quic_kgodara@quicinc.com> <kgodara@codeaurora.org>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Kuogee Hsieh <quic_khsieh@quicinc.com> <khsieh@codeaurora.org>
 Lee Jones <lee@kernel.org> <joneslee@google.com>
@@ -291,19 +329,27 @@ Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
+Liam Mark <quic_lmark@quicinc.com> <lmark@codeaurora.org>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 <linux-hardening@vger.kernel.org> <kernel-hardening@lists.openwall.com>
 Li Yang <leoyang.li@nxp.com> <leoli@freescale.com>
 Li Yang <leoyang.li@nxp.com> <leo@zh-kernel.org>
+Lior David <quic_liord@quicinc.com> <liord@codeaurora.org>
 Lorenzo Pieralisi <lpieralisi@kernel.org> <lorenzo.pieralisi@arm.com>
 Luca Ceresoli <luca.ceresoli@bootlin.com> <luca@lucaceresoli.net>
 Lukasz Luba <lukasz.luba@arm.com> <l.luba@partner.samsung.com>
+Luo Jie <quic_luoj@quicinc.com> <luoj@codeaurora.org>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Maciej W. Rozycki <macro@orcam.me.uk> <macro@linux-mips.org>
+Maharaja Kennadyrajan <quic_mkenna@quicinc.com> <mkenna@codeaurora.org>
+Maheshwar Ajja <quic_majja@quicinc.com> <majja@codeaurora.org>
+Malathi Gottam <quic_mgottam@quicinc.com> <mgottam@codeaurora.org>
+Manikanta Pubbisetty <quic_mpubbise@quicinc.com> <mpubbise@codeaurora.org>
 Manivannan Sadhasivam <mani@kernel.org> <manivannanece23@gmail.com>
 Manivannan Sadhasivam <mani@kernel.org> <manivannan.sadhasivam@linaro.org>
+Manoj Basapathi <quic_manojbm@quicinc.com> <manojbm@codeaurora.org>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Marek Behún <kabel@kernel.org> <marek.behun@nic.cz>
@@ -333,6 +379,7 @@ Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
 Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
 Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
 Matt Redfearn <matt.redfearn@mips.com> <matt.redfearn@imgtec.com>
+Maulik Shah <quic_mkshah@quicinc.com> <mkshah@codeaurora.org>
 Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@brturbo.com.br>
 Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@infradead.org>
@@ -345,7 +392,10 @@ Maxim Mikityanskiy <maxtram95@gmail.com> <maximmi@nvidia.com>
 Maxime Ripard <mripard@kernel.org> <maxime@cerno.tech>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@bootlin.com>
 Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
+Maya Erez <quic_merez@quicinc.com> <merez@codeaurora.org>
 Mayuresh Janorkar <mayur@ti.com>
+Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
+Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
 Michael Buesch <m@bues.ch>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michel Dänzer <michel@tungstengraphics.com>
@@ -356,6 +406,7 @@ Miguel Ojeda <ojeda@kernel.org> <miguel.ojeda.sandonis@gmail.com>
 Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
 Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
 Mike Rapoport <rppt@kernel.org> <rppt@linux.ibm.com>
+Mike Tipton <quic_mdtipton@quicinc.com> <mdtipton@codeaurora.org>
 Miodrag Dinic <miodrag.dinic@mips.com> <miodrag.dinic@imgtec.com>
 Miquel Raynal <miquel.raynal@bootlin.com> <miquel.raynal@free-electrons.com>
 Mitesh shah <mshah@teja.com>
@@ -364,9 +415,13 @@ Morten Welinder <terra@gnome.org>
 Morten Welinder <welinder@anemone.rentec.com>
 Morten Welinder <welinder@darter.rentec.com>
 Morten Welinder <welinder@troll.com>
+Mukesh Ojha <quic_mojha@quicinc.com> <mojha@codeaurora.org>
+Muna Sinada <quic_msinada@quicinc.com> <msinada@codeaurora.org>
+Murali Nalajala <quic_mnalajal@quicinc.com> <mnalajal@codeaurora.org>
 Mythri P K <mythripk@ti.com>
 Nadia Yvette Chambers <nyc@holomorphy.com> William Lee Irwin III <wli@holomorphy.com>
 Nathan Chancellor <nathan@kernel.org> <natechancellor@gmail.com>
+Neeraj Upadhyay <quic_neeraju@quicinc.com> <neeraju@codeaurora.org>
 Neil Armstrong <neil.armstrong@linaro.org> <narmstrong@baylibre.com>
 Nguyen Anh Quynh <aquynh@gmail.com>
 Nicholas Piggin <npiggin@gmail.com> <npiggen@suse.de>
@@ -385,6 +440,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
+Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>
 Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
 Oleksij Rempel <linux@rempel-privat.de> <bug-track@fisher-privat.net>
 Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
@@ -392,6 +448,7 @@ Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <o.rempel@pengutronix.de>
 Oleksij Rempel <linux@rempel-privat.de> <ore@pengutronix.de>
 Oliver Upton <oliver.upton@linux.dev> <oupton@google.com>
+Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
 Pali Rohár <pali@kernel.org> <pali.rohar@gmail.com>
 Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
 Patrick Mochel <mochel@digitalimplant.org>
@@ -403,11 +460,14 @@ Paul E. McKenney <paulmck@kernel.org> <paulmck@linux.vnet.ibm.com>
 Paul E. McKenney <paulmck@kernel.org> <paulmck@us.ibm.com>
 Paul Mackerras <paulus@ozlabs.org> <paulus@samba.org>
 Paul Mackerras <paulus@ozlabs.org> <paulus@au1.ibm.com>
+Pavankumar Kondeti <quic_pkondeti@quicinc.com> <pkondeti@codeaurora.org>
 Peter A Jonsson <pj@ludd.ltu.se>
 Peter Oruba <peter.oruba@amd.com>
 Peter Oruba <peter@oruba.de>
 Pratyush Anand <pratyush.anand@gmail.com> <pratyush.anand@st.com>
 Praveen BP <praveenbp@ti.com>
+Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> <pradeepc@codeaurora.org>
+Prasad Sodagudi <quic_psodagud@quicinc.com> <psodagud@codeaurora.org>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
@@ -416,10 +476,16 @@ Quentin Perret <qperret@qperret.net> <quentin.perret@arm.com>
 Rafael J. Wysocki <rjw@rjwysocki.net> <rjw@sisk.pl>
 Rajeev Nandan <quic_rajeevny@quicinc.com> <rajeevny@codeaurora.org>
 Rajendra Nayak <quic_rjendra@quicinc.com> <rnayak@codeaurora.org>
+Rajeshwari Ravindra Kamble <quic_rkambl@quicinc.com> <rkambl@codeaurora.org>
+Raju P.L.S.S.S.N <quic_rplsssn@quicinc.com> <rplsssn@codeaurora.org>
 Rajesh Shah <rajesh.shah@intel.com>
+Rakesh Pillai <quic_pillair@quicinc.com> <pillair@codeaurora.org>
 Ralf Baechle <ralf@linux-mips.org>
 Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
+Ram Chandra Jangir <quic_rjangir@quicinc.com> <rjangir@codeaurora.org>
 Randy Dunlap <rdunlap@infradead.org> <rdunlap@xenotime.net>
+Ravi Kumar Bokka <quic_rbokka@quicinc.com> <rbokka@codeaurora.org>
+Ravi Kumar Siddojigari <quic_rsiddoji@quicinc.com> <rsiddoji@codeaurora.org>
 Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
@@ -428,6 +494,7 @@ Richard Leitner <richard.leitner@linux.dev> <dev@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
 Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
 Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
+Rocky Liao <quic_rjliao@quicinc.com> <rjliao@codeaurora.org>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>
 Roman Gushchin <roman.gushchin@linux.dev> <klamm@yandex-team.ru>
@@ -445,22 +512,33 @@ Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Santosh Shilimkar <ssantosh@kernel.org>
 Sarangdhar Joshi <spjoshi@codeaurora.org>
 Sascha Hauer <s.hauer@pengutronix.de>
+Sahitya Tummala <quic_stummala@quicinc.com> <stummala@codeaurora.org>
+Sathishkumar Muruganandam <quic_murugana@quicinc.com> <murugana@codeaurora.org>
 Satya Priya <quic_c_skakit@quicinc.com> <skakit@codeaurora.org>
 S.Çağlar Onur <caglar@pardus.org.tr>
+Sayali Lokhande <quic_sayalil@quicinc.com> <sayalil@codeaurora.org>
 Sean Christopherson <seanjc@google.com> <sean.j.christopherson@intel.com>
 Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
+Sean Tranchetti <quic_stranche@quicinc.com> <stranche@codeaurora.org>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
+Senthilkumar N L <quic_snlakshm@quicinc.com> <snlakshm@codeaurora.org>
 Seth Forshee <sforshee@kernel.org> <seth.forshee@canonical.com>
 Shannon Nelson <shannon.nelson@amd.com> <snelson@pensando.io>
+Sharath Chandra Vurukala <quic_sharathv@quicinc.com> <sharathv@codeaurora.org>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
 Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
 Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
+Sibi Sankar <quic_sibis@quicinc.com> <sibis@codeaurora.org>
+Sid Manning <quic_sidneym@quicinc.com> <sidneym@codeaurora.org>
 Simon Arlott <simon@octiron.net> <simon@fire.lp0.eu>
 Simon Kelley <simon@thekelleys.org.uk>
+Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.org>
+Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
+Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundation.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
@@ -468,22 +546,30 @@ Stephen Hemminger <stephen@networkplumber.org> <sthemmin@microsoft.com>
 Stephen Hemminger <stephen@networkplumber.org> <sthemmin@vyatta.com>
 Steve Wise <larrystevenwise@gmail.com> <swise@chelsio.com>
 Steve Wise <larrystevenwise@gmail.com> <swise@opengridcomputing.com>
-Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
+Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com> <subashab@codeaurora.org>
+Subbaraman Narayanamurthy <quic_subbaram@quicinc.com> <subbaram@codeaurora.org>
 Subhash Jadavani <subhashj@codeaurora.org>
+Sudarshan Rajagopalan <quic_sudaraja@quicinc.com> <sudaraja@codeaurora.org>
 Sudeep Holla <sudeep.holla@arm.com> Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
 Sumit Semwal <sumit.semwal@ti.com>
+Surabhi Vishnoi <quic_svishnoi@quicinc.com> <svishnoi@codeaurora.org>
 Takashi YOSHII <takashi.yoshii.zj@renesas.com>
+Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
+Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
 Tejun Heo <htejun@gmail.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Körper <socketcan@esd.eu> <thomas.koerper@esd.eu>
 Thomas Pedersen <twp@codeaurora.org>
 Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
+Tingwei Zhang <quic_tingwei@quicinc.com> <tingwei@codeaurora.org>
+Tirupathi Reddy <quic_tirupath@quicinc.com> <tirupath@codeaurora.org>
 Tobias Klauser <tklauser@distanz.ch> <tobias.klauser@gmail.com>
 Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
 Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
 Tony Luck <tony.luck@intel.com>
+Trilok Soni <quic_tsoni@quicinc.com> <tsoni@codeaurora.org>
 TripleX Chung <xxx.phy@gmail.com> <triplex@zh-kernel.org>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
 Tsuneo Yoshioka <Tsuneo.Yoshioka@f-secure.com>
@@ -496,11 +582,17 @@ Uwe Kleine-König <ukleinek@strlen.de>
 Uwe Kleine-König <ukl@pengutronix.de>
 Uwe Kleine-König <Uwe.Kleine-Koenig@digi.com>
 Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
+Vara Reddy <quic_varar@quicinc.com> <varar@codeaurora.org>
+Varadarajan Narayanan <quic_varada@quicinc.com> <varada@codeaurora.org>
+Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com> <vthiagar@codeaurora.org>
 Vasily Averin <vasily.averin@linux.dev> <vvs@virtuozzo.com>
 Vasily Averin <vasily.averin@linux.dev> <vvs@openvz.org>
 Vasily Averin <vasily.averin@linux.dev> <vvs@parallels.com>
 Vasily Averin <vasily.averin@linux.dev> <vvs@sw.ru>
 Valentin Schneider <vschneid@redhat.com> <valentin.schneider@arm.com>
+Veera Sundaram Sankaran <quic_veeras@quicinc.com> <veeras@codeaurora.org>
+Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com> <vbadigan@codeaurora.org>
+Venkateswara Naralasetty <quic_vnaralas@quicinc.com> <vnaralas@codeaurora.org>
 Vikash Garodia <quic_vgarodia@quicinc.com> <vgarodia@codeaurora.org>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@intel.com>
 Vinod Koul <vkoul@kernel.org> <vinod.koul@linux.intel.com>
@@ -510,11 +602,14 @@ Viresh Kumar <vireshk@kernel.org> <viresh.kumar@st.com>
 Viresh Kumar <vireshk@kernel.org> <viresh.linux@gmail.com>
 Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.org>
 Viresh Kumar <viresh.kumar@linaro.org> <viresh.kumar@linaro.com>
+Vivek Aknurwar <quic_viveka@quicinc.com> <viveka@codeaurora.org>
 Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
 WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
+Wen Gong <quic_wgong@quicinc.com> <wgong@codeaurora.org>
+Wesley Cheng <quic_wcheng@quicinc.com> <wcheng@codeaurora.org>
 Will Deacon <will@kernel.org> <will.deacon@arm.com>
 Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
-- 
2.25.1

